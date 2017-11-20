# rubocop:disable Metrics/ClassLength
class PpmEstimator
  def initialize(params)
    @params = params
  end

  def advance_percentage
    estimator_params[:branch] == 'marines' ? 50 : 60
  end

  def date
    @date ||= Date.parse(estimator_params[:date])
  end

  def full_weight
    @full_weight ||= weight_self_limited + weight_progear_limited + weight_progear_spouse_limited
  end

  def incentive
    @incentive ||= (linehaul_charges + non_linehaul_charges) * inv_linehaul_discount * 0.95
  end

  def start_zip3
    @start_zip3 ||= Zip3.find_by(zip3: estimator_params[:start][0, 3].to_i)
  end

  def end_zip3
    @end_zip3 ||= Zip3.find_by(zip3: estimator_params[:end][0, 3].to_i)
  end

  def peak_season?
    @peak_season ||= (Date.new(date.year, 5, 15)..Date.new(date.year, 9, 30)).cover?(date)
  end

  def selfpack?
    estimator_params[:selfpack] == 'yes'
  end

  def result
    discounted_full_pack_cost = full_pack_cost * inv_linehaul_discount * 0.95
    incentive_without_packing = incentive - discounted_full_pack_cost
    {
      advance: (selfpack? ? incentive : incentive_without_packing) * (advance_percentage / 100.0),
      discounted_full_pack_cost: discounted_full_pack_cost,
      incentive: selfpack? ? incentive : incentive_without_packing,
      incentive_without_packing: incentive_without_packing
    }
  end

  def valid?
    # weight_progear and weight_progear_spouse can be empty, will be regarded as 0
    required_params = %w[rank branch dependents married start end date weight selfpack]

    estimator_params.permitted? &&
      (required_params - estimator_params.keys).empty? &&
      /^\d{5}$/.match?(estimator_params[:start]) &&
      /^\d{5}$/.match?(estimator_params[:end])
  end

  private

  def cwt
    full_weight / 100
  end

  def estimator_params
    @estimator_params ||= @params.permit(:rank, :branch, :dependents, :married, :start, :end, :date, :weight, :weight_progear, :weight_progear_spouse, :selfpack)
  end

  def entitlement
    @entitlement ||= Entitlement.find_by(slug: estimator_params[:rank])
  end

  def entitlement_self
    @entitlement_self ||=
      if estimator_params[:dependents] == 'yes' && entitlement.total_weight_self_plus_dependents
        entitlement.total_weight_self_plus_dependents
      else
        entitlement.total_weight_self
      end
  end

  def entitlement_progear
    @entitlement_progear ||= entitlement.pro_gear_weight || 0
  end

  def entitlement_progear_spouse
    @entitlement_progear_spouse = estimator_params[:married] == 'yes' && entitlement.pro_gear_weight_spouse ? entitlement.pro_gear_weight_spouse : 0
  end

  def weight_self_limited
    [estimator_params[:weight].to_i, entitlement_self].min
  end

  def weight_progear_limited
    [estimator_params[:weight_progear].to_i, entitlement_progear].min
  end

  def weight_progear_spouse_limited
    [estimator_params[:married] == 'yes' ? estimator_params[:weight_progear_spouse].to_i : 0, entitlement_progear_spouse].min
  end

  def full_pack_cost
    @full_pack_cost ||= FullPack.rate(effective_400ng_date, orig_svc_area.services_schedule, full_weight) * cwt
  end

  def orig_svc_area
    @orig_svc_area ||= ServiceArea.from_date_and_svc_area_number(effective_400ng_date, start_zip3.service_area)
  end

  def dest_svc_area
    @dest_svc_area ||= ServiceArea.from_date_and_svc_area_number(effective_400ng_date, end_zip3.service_area)
  end

  def distance
    @distance ||= DtodZip3Distance.dist_mi(start_zip3.zip3, end_zip3.zip3).to_i
  end

  def effective_400ng_date
    # If the user enters a date that's before or after all 400NG rates in the database, then
    # use the 400NG rates with an effective date closest to the date the user gave
    # the FullUnpacks table is the shortest, so should be the quickest to query
    @effective_400ng_date ||=
      if (effective_range = FullUnpack.effective_date_range).cover?(date)
        date
      elsif date < effective_range.min
        effective_range.min
      else
        effective_range.max
      end
  end

  def effective_tdl_date
    # If the user enters a date that's before or after the TDLs in the database, then
    # use the discounts with a TDL closest to the date the user gave
    @effective_tdl_date ||=
      if (tdl_range = TopTspByChannelLinehaulDiscount.tdl_date_range).cover?(date)
        date
      elsif date < tdl_range.min
        tdl_range.min
      else
        tdl_range.max
      end
  end

  def rate_area(zip3, zip5)
    # you can usually get the rate_area from just the ZIP3
    area = zip3.rate_area
    # Sometimes, all 5 digits of the ZIP code are needed to get the rate area
    return area unless area == 'ZIP'
    Zip5RateArea.select(:rate_area).find_by(zip5: zip5).rate_area
  end

  def inv_linehaul_discount
    @inv_linehaul_discount ||= TopTspByChannelLinehaulDiscount.inv_discount(
      # the origin is a rate area
      rate_area(start_zip3, estimator_params[:start].to_i),
      # For CONUS moves, destination is the region.
      # If the orig and dest are in the same state, the region is 15!
      start_zip3.state == end_zip3.state ? 15 : end_zip3.region,
      effective_tdl_date
    )
  end

  def base_rate
    return base_linehaul(distance, full_weight) unless full_weight < 1000
    # pro-rate the 1000 lb baseline rate for shipments less than 1000 lbs
    base_linehaul(distance, 1000) * (full_weight / 1000.0)
  end

  def linehaul_charges
    base_rate + (orig_svc_area.linehaul_factor + dest_svc_area.linehaul_factor) * cwt + shorthaul
  end

  def base_linehaul(dist_mi, wt)
    BaseLinehaul.rate(effective_400ng_date, dist_mi, wt)
  end

  def shorthaul
    return 0 if distance > 800
    Shorthaul.rate(effective_400ng_date, cwt, distance)
  end

  def non_linehaul_charges
    full_pack_cost + cwt * (orig_svc_area.orig_dest_service_charge + dest_svc_area.orig_dest_service_charge + FullUnpack.rate(effective_400ng_date, dest_svc_area.services_schedule))
  end
end
# rubocop:enable Metrics/ClassLength

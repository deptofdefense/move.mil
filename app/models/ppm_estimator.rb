class PpmEstimator
  def initialize(params)
    @params = params
  end

  def rank
    estimator_params[:rank]
  end

  def branch
    estimator_params[:branch]
  end

  def dependents
    estimator_params[:dependents]
  end

  def married
    estimator_params[:married]
  end

  def start
    estimator_params[:start]
  end

  def end_
    estimator_params[:end]
  end

  def date
    estimator_params[:date]
  end

  def weight
    estimator_params[:weight]
  end

  def weight_progear
    estimator_params[:weight_progear]
  end

  def weight_progear_spouse
    estimator_params[:weight_progear_spouse]
  end

  def selfpack
    estimator_params[:selfpack]
  end

  def result
    get_weight_entitlement(rank, dependents == 'yes')
    @full_weight = get_full_allowed_weight
    incentive = get_ppm_cost_estimate
    incentive_without_packing = incentive - @full_pack_cost
    advance_percentage = (branch == 'marines') ? 50 : 60
    results = {
      advance: incentive * (advance_percentage / 100.0),
      advance_without_packing: incentive_without_packing * (advance_percentage / 100.0),
      advance_percentage: advance_percentage,
      date: date,
      end_basepoint_city: @end_basepoint_city,
      end_state: @end_state,
      entitlement_weight: @entitlement_weight,
      entitlement_progear: @entitlement_progear,
      entitlement_progear_spouse: @entitlement_progear_spouse,
      full_pack_cost: @full_pack_cost,
      full_weight: @full_weight,
      incentive: incentive,
      incentive_without_packing: incentive_without_packing,
      start_basepoint_city: @start_basepoint_city,
      start_state: @start_state
    }
  end

  def valid?
    estimator_params.permitted? &&
    rank.present? &&
    branch.present? &&
    dependents.present? &&
    married.present? &&
    start.present? &&
    end_.present? &&
    date.present? &&
    weight.present? &&
    selfpack.present?
    # weight_progear and weight_progear_spouse can be empty, will be regarded as 0
  end

  private

  def estimator_params
    @estimator_params ||= @params.permit(:rank, :branch, :dependents, :married, :start, :end, :date, :weight, :weight_progear, :weight_progear_spouse, :selfpack)
  end

  def get_weight_entitlement(rank, dependents)
    entitlement = Entitlement.find_by(slug: rank)
    if dependents && entitlement['total_weight_self_plus_dependents']
      @entitlement_weight = entitlement['total_weight_self_plus_dependents']
    else
      @entitlement_weight = entitlement['total_weight_self']
    end
    @entitlement_progear = entitlement['pro_gear_weight'] ? entitlement['pro_gear_weight'] : 0;
    @entitlement_progear_spouse = (married == 'yes' && entitlement['pro_gear_weight_spouse']) ? entitlement['pro_gear_weight_spouse'] : 0
  end

  def get_ppm_cost_estimate
    # TODO Intra-AK
    # TODO OCONUS
    # TODO error handling
    orig_zip3 = Zip3.find_by(zip3: start[0,3].to_i)
    dest_zip3 = Zip3.find_by(zip3: end_[0,3].to_i)

    @start_basepoint_city = orig_zip3['basepoint_city']
    @start_state = orig_zip3['state']
    @end_basepoint_city = dest_zip3['basepoint_city']
    @end_state = dest_zip3['state']

    date_parsed = Date.parse(date)
    year = date_parsed.year

    orig_svc_area = ServiceArea.find_by(year: year, service_area: orig_zip3['service_area'])
    dest_svc_area = ServiceArea.find_by(year: year, service_area: dest_zip3['service_area'])

    distance = DtodZip3Distance.find_by(orig_zip3: orig_zip3['zip3'], dest_zip3: dest_zip3['zip3'])['dist_mi'].to_i

    lh_charges = get_linehaul_charges(orig_svc_area, dest_svc_area, distance, @full_weight, year)
    non_lh_charges = get_non_linehaul_charges(orig_svc_area, dest_svc_area, @full_weight, year)

    inv_discount = get_inv_linehaul_discount(orig_zip3, dest_zip3, date_parsed)
    @full_pack_cost *= inv_discount * 0.95
    return (lh_charges + non_lh_charges) * inv_discount * 0.95
  end

  def get_full_allowed_weight
    wt = weight.to_i
    wt_allowed = [wt, @entitlement_weight].min

    wpg = weight_progear.present? ? weight_progear.to_i : 0
    wpg_allowed = [wpg, @entitlement_progear].min

    wpgs = (weight_progear_spouse.present? && (married == 'yes')) ? weight_progear_spouse.to_i : 0
    wpgs_allowed = [wpgs, @entitlement_progear_spouse].min

    return wt_allowed + wpg_allowed + wpgs_allowed
  end

  def get_inv_linehaul_discount(orig_zip3, dest_zip3, date)
    # Origin is the rate_area, which you can usually get from just the ZIP3
    orig = orig_zip3['rate_area']
    # Sometimes, all 5 digits of the ZIP code are needed to get the rate area
    if (orig == 'ZIP')
      orig = Zip5RateArea.find_by(zip5: orig_zipcode)['rate_area']
    end

    # For CONUS moves, destination is the region.
    # If the orig and dest are in the same state, the region is 15!
    if (orig_zip3['state'] == dest_zip3['state'])
      dest = 15
    else
      dest = dest_zip3['region']
    end

    bvs = TopBestValueScore.find_by(orig: orig, dest: dest, year: date.year)
    # TODO return rate from correct performance period
    return bvs['perf_period_2'] / 100
  end

  def get_linehaul_charges(orig_svc_area, dest_svc_area, distance, wt, year)
    base_linehaul = get_base_linehaul(distance, wt, year)
    cwt = wt / 100
    orig_linehaul_factor = orig_svc_area['linehaul_factor'] * cwt
    dest_linehaul_factor = dest_svc_area['linehaul_factor'] * cwt
    shorthaul = get_shorthaul(distance, wt, year)
    return base_linehaul + orig_linehaul_factor + dest_linehaul_factor + shorthaul
  end

  def get_base_linehaul(distance, wt, year)
    # TODO handle distances and weights beyond 3800 mi and 24000 lbs
    # TODO handle intra-AK
    # TODO handle inter-AK
    # TODO handle lookup failures
    conus_linehaul = BaselineRate.find_by('year = ? AND ? BETWEEN dist_mi_min AND dist_mi_max AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, distance, wt)
    return conus_linehaul['rate']
  end

  def get_shorthaul(distance, wt, year)
    if distance > 800
      return 0
    end

    cwt_m = get_hundred_weight_miles(distance, wt)
    shorthaul = Shorthaul.find_by('year = ? AND ? BETWEEN cwt_mi_min AND cwt_mi_max', year, cwt_m)
    return shorthaul['rate']
  end

  def get_hundred_weight_miles(distance, wt)
    # From page 61 of '2017 400NG Tariff.pdf':
    # "Determine CWT-M by multiplying total shipment MILES times CWT."
    return distance * (wt / 100)
  end

  def get_non_linehaul_charges(orig_svc_area, dest_svc_area, wt, year)
    full_pack = FullPack.find_by('year = ? AND schedule = ? AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, orig_svc_area['services_schedule'], wt)
    full_unpack = FullUnpack.find_by(year: year, schedule: dest_svc_area['services_schedule'])
    cwt = wt / 100

    @full_pack_cost = full_pack['rate'] * cwt
    return (orig_svc_area['orig_dest_service_charge'] + dest_svc_area['orig_dest_service_charge'] + full_pack['rate'] + full_unpack['rate']) * cwt
  end

end

class PpmEstimatorController < ApplicationController

  def index
    entitlements
    return unless params[:start].present?
    get_weight_entitlement(params[:rank], params[:dependents] == 'yes')
    @incentive = get_ppm_cost_estimate
    @incentive_without_packing = @incentive - @full_pack_cost
    @date = params[:date] if params[:date].present?
    @weight = params[:weight] if params[:weight].present?
    @advance_percentage = params[:branch] == 'marines' ? 50 : 60
    @advance = @incentive * (@advance_percentage / 100.0)
  end

  private

  def entitlements
    @entitlements ||= Entitlement.all
  end

  def get_weight_entitlement(rank, dependents)
    entitlement = Entitlement.find_by(slug: rank)
    if dependents
      @entitlement_weight = entitlement['total_weight_self_plus_dependents']
    else
      @entitlement_weight = entitlement['total_weight_self']
    end
    @entitlement_progear = entitlement['pro_gear_weight']
    @entitlement_progear_spouse = params[:married] == 'yes' ? entitlement['pro_gear_weight_spouse'] : 0
  end

  def get_ppm_cost_estimate
    # TODO Intra-AK
    # TODO OCONUS
    # TODO error handling
    orig_zip3 = Zip3.find_by(zip3: params[:start][0,3].to_i)
    dest_zip3 = Zip3.find_by(zip3: params[:end][0,3].to_i)

    @start_basepoint_city = orig_zip3['basepoint_city']
    @start_state = orig_zip3['state']
    @end_basepoint_city = dest_zip3['basepoint_city']
    @end_state = dest_zip3['state']

    date = Date.parse(params[:date])
    year = date.year

    weight = params[:weight].to_i

    orig_svc_area = ServiceArea.find_by(year: year, service_area: orig_zip3['service_area'])
    dest_svc_area = ServiceArea.find_by(year: year, service_area: dest_zip3['service_area'])

    distance = DtodZip3Distance.find_by(orig_zip3: orig_zip3['zip3'], dest_zip3: dest_zip3['zip3'])['dist_mi']

    lh_charges = get_linehaul_charges(orig_svc_area, dest_svc_area, distance, weight, year)
    non_lh_charges = get_non_linehaul_charges(orig_svc_area, dest_svc_area, weight, year)

    inv_discount = get_inv_linehaul_discount(orig_zip3, dest_zip3, date)
    @full_pack_cost *= inv_discount * 0.95
    return (lh_charges + non_lh_charges) * inv_discount * 0.95
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

  def get_linehaul_charges(orig_svc_area, dest_svc_area, distance, weight, year)
    base_linehaul = get_base_linehaul(distance, weight, year)
    cwt = weight / 100
    orig_linehaul_factor = orig_svc_area['linehaul_factor'] * cwt
    dest_linehaul_factor = dest_svc_area['linehaul_factor'] * cwt
    shorthaul = get_shorthaul(distance, weight, year)
    return base_linehaul + orig_linehaul_factor + dest_linehaul_factor + shorthaul
  end

  def get_base_linehaul(distance, weight, year)
    # TODO handle distances and weights beyond 3800 mi and 24000 lbs
    # TODO handle intra-AK
    # TODO handle inter-AK
    # TODO handle lookup failures
    conus_linehaul = BaselineRate.find_by('year = ? AND ? BETWEEN dist_mi_min AND dist_mi_max AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, distance, weight)
    return conus_linehaul['rate']
  end

  def get_shorthaul(distance, weight, year)
    if distance > 800
      return 0
    end

    cwt_m = get_hundred_weight_miles(distance, weight)
    shorthaul = Shorthaul.find_by('year = ? AND ? BETWEEN cwt_mi_min AND cwt_mi_max', year, cwt_m)
    return shorthaul['rate']
  end

  def get_hundred_weight_miles(distance, weight)
    # From page 61 of '2017 400NG Tariff.pdf':
    # "Determine CWT-M by multiplying total shipment MILES times CWT."
    return distance * (weight / 100)
  end

  def get_non_linehaul_charges(orig_svc_area, dest_svc_area, weight, year)
    full_pack = FullPack.find_by('year = ? AND schedule = ? AND ? BETWEEN weight_lbs_min AND weight_lbs_max', year, orig_svc_area['services_schedule'], weight)
    full_unpack = FullUnpack.find_by(year: year, schedule: dest_svc_area['services_schedule'])
    cwt = weight / 100

    @full_pack_cost = full_pack['rate'] * cwt
    return (orig_svc_area['orig_dest_service_charge'] + dest_svc_area['orig_dest_service_charge'] + full_pack['rate'] + full_unpack['rate']) * cwt
  end

end

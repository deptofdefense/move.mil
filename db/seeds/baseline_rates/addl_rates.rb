class AdditionalRates
  def self.parse(sheet, daterange)
    shorthauls = Array.new
    full_packs = Array.new
    full_unpacks = Array.new
    (3..sheet.last_row).each do |i|
      # Shorthaul rates
      if sheet.cell(i, 1) == 999
        cwtm_min, cwtm_max = parse_shorthaul(sheet.cell(i, 4))
        shorthauls << [Range.new(cwtm_min, cwtm_max), BigDecimal.new(sheet.cell(i, 5), 8), daterange]
      end

      next if sheet.cell(i, 2) != '105A'

      wt_min, wt_max = parse_full_pack(sheet.cell(i,4))
      full_packs << [sheet.cell(i, 3).to_i, Range.new(wt_min.to_i, wt_max.to_i), BigDecimal.new(sheet.cell(i,5), 10), daterange]

      unpack = parse_full_unpack(sheet.cell(i,6))
      full_unpacks << [sheet.cell(i, 3).to_i, BigDecimal.new(unpack, 10), daterange] unless unpack.nil?
    end

    [full_packs, full_unpacks, shorthauls]
  end

  private

  def self.parse_shorthaul(desc)
    # the shorthaul prose has thousands separators in the numbers
    /less than or equal to (?<cwtm_max>[\d,]+)/ =~ desc
    return [0, cwtm_max.delete(',').to_i] unless $LAST_MATCH_INFO.nil?

    /between (?<cwtm_min>[\d,]+) and (?<cwtm_max>[\d,]+)/ =~ desc
    return [cwtm_min.delete(',').to_i, cwtm_max.delete(',').to_i] unless $LAST_MATCH_INFO.nil?

    /greater than (?<cwtm_min>[\d,]+)/ =~ desc
    # maximum 32 bit signed integer, minus 2 because postgres makes the high end of a range exclusive, not inclusive
    [cwtm_min.delete(',').to_i + 1, 2**31 - 2]
  end

  def self.parse_full_pack(desc)
    # the full pack weight range is expressed in prose
    /(?<wt_max>\d+) lbs and under/ =~ desc
    return [0, wt_max.to_i] unless $LAST_MATCH_INFO.nil?

    /(?<wt_min>\d+) lbs to (?<wt_max>\d+) lbs/ =~ desc
    return [wt_min.to_i, wt_max.to_i] unless $LAST_MATCH_INFO.nil?

    /over (?<wt_min>\d+) lbs/ =~ desc
    # maximum 32 bit signed integer, minus 2 because postgres makes the high end of a range exclusive, not inclusive
    [wt_min.to_i + 1, 2**31 - 2]
  end

  def self.parse_full_unpack(desc)
    # the full unpack rate is weight-independent, only mentioned once per schedule, and is also expressed in prose
    /Unpack is (?<unpack>[\d\.]+) per cwt regardless of weight/ =~ desc
    unpack
  end
end

require 'roo'

module Seeds
  module Support
    class Domestic400NG
      attr_reader :schedules, :full_packs, :full_unpacks, :shorthauls, :conus_linehauls, :intra_ak_linehauls

      def initialize(path, daterange)
        rates = Roo::Spreadsheet.open(path)

        @daterange = daterange
        @schedules = parse_geographic_schedules(rates.sheet('Geographical Schedule'))
        @full_packs, @full_unpacks, @shorthauls = parse_addl_rates(rates.sheet('Additional Rates'))
        @conus_linehauls, @intra_ak_linehauls = parse_linehauls(rates.sheet('Linehaul'))
      end

      private

      def flatten_linehaul_rates(sheet, firstRow, lastRow, firstColumn, lastColumn, maxDistance)
        output = []

        Range.new(firstRow, lastRow).each do |r|
          Range.new(firstColumn, lastColumn).each do |c|
            output << [
              Range.new(sheet.cell(r, 2), sheet.cell(r, 3)),
              Range.new(sheet.cell(2, c), sheet.cell(3, c)),
              sheet.cell(r, c),
              @daterange
            ]
          end
        end

        # Increment rates for each addl 100 miles using numbers after lastRow, up to maxDistance
        numWeightClasses = (lastColumn - firstColumn) + 1
        d = sheet.cell(lastRow, 3) + 100

        while d <= maxDistance do
          Range.new(firstColumn, lastColumn).each do |c|
            output << [
              Range.new(d - 99, d),
              Range.new(sheet.cell(2, c), sheet.cell(3, c)),
              output[-numWeightClasses][2] + sheet.cell(lastRow + 1, c),
              @daterange
            ]
          end
          d += 100
        end

        output
      end

      def parse_addl_rates(sheet)
        shorthauls = []
        full_packs = []
        full_unpacks = []

        Range.new(3, sheet.last_row).each do |i|
          # Shorthaul rates
          if sheet.cell(i, 1) == 999
            cwtm_min, cwtm_max = parse_shorthaul(sheet.cell(i, 4))
            shorthauls << [Range.new(cwtm_min, cwtm_max), BigDecimal.new(sheet.cell(i, 5), 8), @daterange]
          end

          next if sheet.cell(i, 2) != '105A'

          wt_min, wt_max = parse_full_pack(sheet.cell(i,4))
          full_packs << [sheet.cell(i, 3).to_i, Range.new(wt_min.to_i, wt_max.to_i), BigDecimal.new(sheet.cell(i,5), 10), @daterange]

          unpack = parse_full_unpack(sheet.cell(i,6))
          full_unpacks << [sheet.cell(i, 3).to_i, BigDecimal.new(unpack, 10), @daterange] unless unpack.nil?
        end

        [full_packs, full_unpacks, shorthauls]
      end

      def parse_geographic_schedules(sheet)
        schedules = []

        # skip the two header rows
        Range.new(3, sheet.last_row).each do |i|
          schedules << [sheet.cell(i, 1).to_i, sheet.cell(i, 2), sheet.cell(i, 3), sheet.cell(i, 4), sheet.cell(i, 5), @daterange]
        end

        schedules
      end

      def parse_full_pack(desc)
        # the full pack weight range is expressed in prose
        /(?<wt_max>\d+) lbs and under/ =~ desc
        return [0, wt_max.to_i] unless $LAST_MATCH_INFO.nil?

        /(?<wt_min>\d+) lbs to (?<wt_max>\d+) lbs/ =~ desc
        return [wt_min.to_i, wt_max.to_i] unless $LAST_MATCH_INFO.nil?

        /over (?<wt_min>\d+) lbs/ =~ desc

        # maximum 32 bit signed integer, minus 2 because postgres makes the high end of a range exclusive, not inclusive
        [wt_min.to_i + 1, 2**31 - 2]
      end

      def parse_full_unpack(desc)
        # the full unpack rate is weight-independent, only mentioned once per schedule, and is also expressed in prose
        /Unpack is (?<unpack>[\d\.]+) per cwt regardless of weight/ =~ desc

        unpack
      end

      def parse_linehauls(sheet)
        conus_rates = flatten_linehaul_rates(sheet, 4, 57, 5, 98, 6000)
        intra_ak_rates = flatten_linehaul_rates(sheet, 63, 88, 5, 98, 2000)

        [conus_rates, intra_ak_rates]
      end

      def parse_shorthaul(desc)
        # the shorthaul prose has thousands separators in the numbers
        /less than or equal to (?<cwtm_max>[\d,]+)/ =~ desc
        return [0, cwtm_max.delete(',').to_i] unless $LAST_MATCH_INFO.nil?

        /between (?<cwtm_min>[\d,]+) and (?<cwtm_max>[\d,]+)/ =~ desc
        return [cwtm_min.delete(',').to_i, cwtm_max.delete(',').to_i] unless $LAST_MATCH_INFO.nil?

        /greater than (?<cwtm_min>[\d,]+)/ =~ desc

        # maximum 32 bit signed integer, minus 2 because postgres makes the high end of a range exclusive, not inclusive
        [cwtm_min.delete(',').to_i + 1, 2**31 - 2]
      end
    end
  end
end

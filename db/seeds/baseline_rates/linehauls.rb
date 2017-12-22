module Seeds
  module BaselineRates
    class Domestic400NG
      private

      def parse_linehauls(sheet)
        conus_rates = flatten_linehaul_rates(sheet, 4, 57, 5, 98, 6000)
        intra_ak_rates = flatten_linehaul_rates(sheet, 63, 88, 5, 98, 2000)

        [conus_rates, intra_ak_rates]
      end

      def flatten_linehaul_rates(sheet, firstRow, lastRow, firstColumn, lastColumn, maxDistance)
        output = Array.new

        (firstRow..lastRow).each do |r|
          (firstColumn..lastColumn).each do |c|
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
          (firstColumn..lastColumn).each do |c|
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
    end
  end
end

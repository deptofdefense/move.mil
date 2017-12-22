module Seeds
  module BaselineRates
    class Domestic400NG
      private

      def parse_geographic_schedules(sheet)
        schedules = Array.new
        # skip the two header rows
        (3..sheet.last_row).each do |i|
          schedules << [sheet.cell(i, 1).to_i, sheet.cell(i, 2), sheet.cell(i, 3), sheet.cell(i, 4), sheet.cell(i, 5), @daterange]
        end
        schedules
      end
    end
  end
end

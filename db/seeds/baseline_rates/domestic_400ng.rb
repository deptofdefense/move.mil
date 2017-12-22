require 'roo'

require_relative 'addl_rates'
require_relative 'geographic_schedules'
require_relative 'linehauls'

module Seeds
  module BaselineRates
    class Domestic400NG
      attr_reader :schedules, :full_packs, :full_unpacks, :shorthauls, :conus_linehauls, :intra_ak_linehauls

      def initialize(path, daterange)
        rates = Roo::Spreadsheet.open(path)
        @daterange = daterange
        @schedules = parse_geographic_schedules(rates.sheet('Geographical Schedule'))
        @full_packs, @full_unpacks, @shorthauls = parse_addl_rates(rates.sheet('Additional Rates'))
        @conus_linehauls, @intra_ak_linehauls = parse_linehauls(rates.sheet('Linehaul'))
      end
    end
  end
end

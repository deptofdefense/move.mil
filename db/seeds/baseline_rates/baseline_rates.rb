require 'roo'

require_relative 'addl_rates'
require_relative 'geographic_schedules'
require_relative 'linehaul'

class BaselineRates
  attr_reader :schedules, :full_packs, :full_unpacks, :shorthauls, :conus_linehauls, :intra_ak_linehauls

  def initialize(path, daterange)
    rates = Roo::Spreadsheet.open(path)
    @schedules = GeographicSchedules::parse(rates.sheet('Geographical Schedule'), daterange)
    @full_packs, @full_unpacks, @shorthauls = AdditionalRates::parse(rates.sheet('Additional Rates'), daterange)
    @conus_linehauls, @intra_ak_linehauls = Linehaul::parse(rates.sheet('Linehaul'), daterange)
  end
end

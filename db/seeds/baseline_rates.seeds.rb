require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

require_relative 'support/domestic_400ng'

module Seeds
  class BaselineRates
    def initialize(date_range:, file_path:)
      @date_range = date_range
      @file_path = file_path.to_s
    end

    def seed!
      ServiceArea.bulk_import [:service_area, :name, :services_schedule, :linehaul_factor, :orig_dest_service_charge, :effective], rates.schedules
      FullPack.bulk_import [:schedule, :weight_lbs, :rate, :effective], rates.full_packs
      FullUnpack.bulk_import [:schedule, :rate, :effective], rates.full_unpacks
      Shorthaul.bulk_import [:cwt_mi, :rate, :effective], rates.shorthauls
      ConusLinehaul.bulk_import [:dist_mi, :weight_lbs, :rate, :effective], rates.conus_linehauls, batch_size: 500
      IntraAlaskaLinehaul.bulk_import [:dist_mi, :weight_lbs, :rate, :effective], rates.intra_ak_linehauls, batch_size: 500
    end

    private

    def rates
      @rates ||= Seeds::Support::Domestic400NG.new(file_path: @file_path, date_range: @date_range)
    end
  end
end

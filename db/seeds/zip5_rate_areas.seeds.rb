require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

module Seeds
  class Zip5RateAreas
    def seed!
      Zip5RateArea.import [:zip5, :rate_area], zip5_rate_areas
    end

    private

    def zip5_rate_areas
      CSV.read(Rails.root.join('lib', 'data', 'zip5_rate_areas.csv'))
    end
  end
end

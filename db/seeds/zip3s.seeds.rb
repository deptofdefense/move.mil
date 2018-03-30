require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

module Seeds
  class Zip3s
    def seed!
      Zip3.import [:zip3, :basepoint_city, :state, :service_area, :rate_area, :region], zip3s
    end

    private

    def zip3s
      CSV.read(Rails.root.join('lib', 'data', 'zip3.csv'))
    end
  end
end

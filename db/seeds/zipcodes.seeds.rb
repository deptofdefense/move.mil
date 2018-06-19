require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

module Seeds
  class Zipcodes
    def seed!
      State.bulk_import states[0], states.slice(1, states.length - 1)
      Zipcode.bulk_import [:code, :city, :state_id, :lat, :lon], zipcodes
    end

    private

    def states
      # From https://github.com/midwire/free_zipcode_data/raw/master/all_us_states.csv
      @states ||= CSV.read(Rails.root.join('lib', 'data', 'all_us_states.csv'), return_headers: false)
    end

    def state_ids_by_abbr
      @state_ids_by_abbr ||= State.pluck(:abbr, :id).to_h
    end

    def zipcodes
      # From https://github.com/midwire/free_zipcode_data/raw/master/all_us_zipcodes.csv
      unmapped_zipcodes = CSV.read(Rails.root.join('lib', 'data', 'all_us_zipcodes.csv'), return_headers: false)
      unmapped_zipcodes = unmapped_zipcodes.slice(1, unmapped_zipcodes.length - 1)
      unmapped_zipcodes.map { |z| [z[0], z[1].titleize, state_ids_by_abbr[z[2]], z[5], z[6]] }
    end
  end
end

require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'csv'

module Seeds
  class DtodZip3Distances
    def seed!
      DtodZip3Distance.import [:orig_zip3, :dest_zip3, :dist_mi], dtod_zip3_distances, { batch_size: 500, validate: false }
    end

    private

    def dtod_zip3_distances
      CSV.read(Rails.root.join('lib', 'data', 'zip3_dtod_output.csv'), { col_sep: ' ', headers: false })
    end
  end
end

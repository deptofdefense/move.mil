class CreateDtodZip3Distances < ActiveRecord::Migration[5.1]
  def change
    create_table :dtod_zip3_distances do |t|
      t.integer :orig_zip3
      t.integer :dest_zip3
      t.float :dist_mi

      t.timestamps
    end
  end
end

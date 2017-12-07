class CreateZip3s < ActiveRecord::Migration[5.1]
  def change
    create_table :zip3s do |t|
      t.integer :zip3
      t.text :basepoint_city
      t.text :state
      t.integer :service_area
      t.text :rate_area
      t.integer :region

      t.timestamps
    end
  end
end

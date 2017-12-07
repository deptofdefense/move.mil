class CreateServiceAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :service_areas do |t|
      t.integer :service_area
      t.text :name
      t.integer :services_schedule
      t.decimal :linehaul_factor, scale: 2, precision: 7
      t.decimal :orig_dest_service_charge, scale: 2, precision: 7
      t.daterange :effective

      t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.references :locatable, polymorphic: true
      t.text :street_address
      t.text :extended_address
      t.text :locality
      t.text :region
      t.text :region_code
      t.text :postal_code
      t.text :country_name
      t.text :country_code
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end

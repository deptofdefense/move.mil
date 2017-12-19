class CreateWeightScales < ActiveRecord::Migration[5.1]
  def change
    create_table :weight_scales do |t|
      t.text :name, null: false
      t.text :street_address
      t.text :extended_address
      t.text :locality
      t.text :region
      t.text :region_code
      t.text :postal_code
      t.text :country_name
      t.text :country_code
      t.float :latitude
      t.float :longitude
      t.json :email_addresses, default: []
      t.json :phone_numbers, default: []
      t.json :urls, default: []
      t.text :hours
      t.text :note

      t.timestamps
    end
  end
end

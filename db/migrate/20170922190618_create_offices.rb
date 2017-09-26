class CreateOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :offices do |t|
      t.text :type
      t.references :shipping_office, index: true
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
      t.text :services, array: true, default: []

      t.timestamps
    end
  end
end

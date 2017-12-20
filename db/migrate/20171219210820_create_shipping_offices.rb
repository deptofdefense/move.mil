class CreateShippingOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_offices do |t|
      t.text :name, null: false
      t.json :email_addresses, default: []
      t.json :phone_numbers, default: []
      t.json :urls, default: []
      t.text :services, array: true, default: []
      t.text :hours
      t.text :note

      t.timestamps
    end
  end
end

class CreateTransportationOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :transportation_offices do |t|
      t.references :ppso, foreign_key: true
      t.text :name
      t.text :address
      t.text :city
      t.text :state
      t.text :postal_code
      t.text :country
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end

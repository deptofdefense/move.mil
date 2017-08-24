class CreatePpsos < ActiveRecord::Migration[5.1]
  def change
    create_table :ppsos do |t|
      t.text :name
      t.text :address
      t.text :city
      t.text :state
      t.text :postal_code
      t.text :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

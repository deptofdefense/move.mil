class CreateZipCodeTabulationAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_code_tabulation_areas do |t|
      t.text :zipcode, null: false
      t.float :lat, null: false
      t.float :lng, null: false
    end
  end
end

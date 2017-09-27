class CreateZipCodeTabulationAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_code_tabulation_areas do |t|
      t.text :zip_code, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
    end
  end
end

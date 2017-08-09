class CreateZipCodeTabulationAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_code_tabulation_areas do |t|
      t.text :zipcode
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end

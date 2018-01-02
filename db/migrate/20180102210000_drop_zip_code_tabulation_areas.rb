class DropZipCodeTabulationAreas < ActiveRecord::Migration[5.1]
  def change
    drop_table :zip_code_tabulation_areas
  end
end

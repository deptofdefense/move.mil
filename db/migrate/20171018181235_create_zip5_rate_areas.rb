class CreateZip5RateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :zip5_rate_areas do |t|
      t.integer :zip5
      t.text :rate_area

      t.timestamps
    end
  end
end

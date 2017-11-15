class CreateFullPacks < ActiveRecord::Migration[5.1]
  def change
    create_table :full_packs do |t|
      t.integer :schedule
      t.int4range :weight_lbs
      t.decimal :rate, scale: 2, precision: 7
      t.integer :year

      t.timestamps
    end
  end
end

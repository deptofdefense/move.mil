class CreateFullUnpacks < ActiveRecord::Migration[5.1]
  def change
    create_table :full_unpacks do |t|
      t.integer :schedule
      t.decimal :rate, scale: 5, precision: 8
      t.daterange :effective

      t.timestamps
    end
  end
end

class CreateShorthauls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorthauls do |t|
      t.int4range :cwt_mi
      t.decimal :rate, scale: 2, precision: 7
      t.daterange :effective

      t.timestamps
    end
  end
end

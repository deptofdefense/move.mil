class CreateShorthauls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorthauls do |t|
      t.int4range :cwt_mi
      t.decimal :rate, scale: 2, precision: 7
      t.integer :year

      t.timestamps
    end
    add_index :shorthauls, :year
  end
end

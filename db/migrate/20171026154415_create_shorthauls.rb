class CreateShorthauls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorthauls do |t|
      t.integer :cwt_mi_min
      t.integer :cwt_mi_max
      t.decimal :rate, scale: 2, precision: 7
      t.integer :year

      t.timestamps
    end
    add_index :shorthauls, :year
  end
end

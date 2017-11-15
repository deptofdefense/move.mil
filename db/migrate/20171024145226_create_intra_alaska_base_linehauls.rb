class CreateIntraAlaskaBaseLinehauls < ActiveRecord::Migration[5.1]
  def change
    create_table :intra_alaska_base_linehauls do |t|
      t.integer :dist_mi_min
      t.integer :dist_mi_max
      t.integer :weight_lbs_min
      t.integer :weight_lbs_max
      t.integer :rate
      t.integer :year

      t.timestamps
    end
    add_index :intra_alaska_base_linehauls, :year
  end
end

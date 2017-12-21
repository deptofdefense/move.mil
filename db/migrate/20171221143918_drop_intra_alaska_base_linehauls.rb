class DropIntraAlaskaBaseLinehauls < ActiveRecord::Migration[5.1]
  def change
    drop_table :intra_alaska_base_linehauls do |t|
      t.int4range :dist_mi, null: false
      t.int4range :weight_lbs, null: false
      t.integer :rate, null: false
      t.daterange :effective, null: false

      t.timestamps null: false
    end
  end
end

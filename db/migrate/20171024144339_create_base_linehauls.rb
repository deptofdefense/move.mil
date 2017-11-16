class CreateBaseLinehauls < ActiveRecord::Migration[5.1]
  def change
    create_table :base_linehauls do |t|
      t.int4range :dist_mi
      t.int4range :weight_lbs
      t.integer :rate
      t.daterange :effective

      t.timestamps
    end
  end
end

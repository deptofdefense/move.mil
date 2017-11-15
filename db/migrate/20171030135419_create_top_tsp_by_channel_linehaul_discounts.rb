class CreateTopTspByChannelLinehaulDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :top_tsp_by_channel_linehaul_discounts do |t|
      t.text :orig
      t.text :dest
      t.decimal :perf_period_h
      t.decimal :perf_period_hs
      t.decimal :perf_period_1
      t.decimal :perf_period_1s
      t.decimal :perf_period_2
      t.decimal :perf_period_2s
      t.decimal :perf_period_3
      t.decimal :perf_period_3s
      t.decimal :perf_period_4
      t.decimal :perf_period_4s
      t.decimal :perf_period_5
      t.decimal :perf_period_5s
      t.integer :year

      t.timestamps
    end
  end
end

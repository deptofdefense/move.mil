class CreateTopTspByChannelLinehaulDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :top_tsp_by_channel_linehaul_discounts do |t|
      t.text :orig
      t.text :dest
      t.daterange :tdl
      t.decimal :discount

      t.timestamps
    end

    add_index :top_tsp_by_channel_linehaul_discounts, :tdl
  end
end

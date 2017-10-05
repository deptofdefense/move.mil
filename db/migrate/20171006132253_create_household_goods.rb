class CreateHouseholdGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :household_goods do |t|
      t.string :name, null: false
      t.integer :weight, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end

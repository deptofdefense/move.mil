class CreateHouseholdGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :household_goods do |t|
      t.string :name
      t.integer :weight
      t.references :household_good_category, foreign_key: true

      t.timestamps
    end
  end
end

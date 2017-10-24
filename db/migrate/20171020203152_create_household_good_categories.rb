class CreateHouseholdGoodCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :household_good_categories do |t|
      t.string :name, null: false
      t.string :icon, null: false

      t.timestamps
    end
    add_index :household_good_categories, :name, unique: true
  end
end

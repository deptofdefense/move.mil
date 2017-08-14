class CreateEntitlements < ActiveRecord::Migration[5.1]
  def change
    create_table :entitlements do |t|
      t.string :rank, null: false
      t.integer :total_weight_self, null: false
      t.integer :total_weight_self_plus_dependents
      t.integer :pro_gear_weight
      t.integer :pro_gear_weight_spouse
      t.text :slug

      t.timestamps
    end
  end
end

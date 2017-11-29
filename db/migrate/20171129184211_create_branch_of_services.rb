class CreateBranchOfServices < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_of_services do |t|
      t.string :name, null: false
      t.integer :display_order, null: false
      t.string :slug, null: false

      t.timestamps
    end
  end
end

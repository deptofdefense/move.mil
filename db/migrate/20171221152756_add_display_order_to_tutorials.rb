class AddDisplayOrderToTutorials < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorials, :display_order, :integer
  end
end

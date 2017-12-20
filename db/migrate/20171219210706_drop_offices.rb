class DropOffices < ActiveRecord::Migration[5.1]
  def change
    drop_table :offices
  end
end

class AddHoursToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :hours, :text
  end
end

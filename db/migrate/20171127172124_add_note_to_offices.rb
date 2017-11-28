class AddNoteToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :note, :text
  end
end

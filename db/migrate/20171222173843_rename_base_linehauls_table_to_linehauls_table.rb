class RenameBaseLinehaulsTableToLinehaulsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :base_linehauls, :linehauls
  end
end

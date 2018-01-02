class DropInstallations < ActiveRecord::Migration[5.1]
  def change
    drop_table :installations
  end
end

class AddTypeToBaseLinehauls < ActiveRecord::Migration[5.1]
  def change
    add_column :base_linehauls, :type, :string
  end
end

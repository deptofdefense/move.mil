class RemoveBranchFromBranchOfServiceContacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :branch_of_service_contacts, :branch, :text
  end
end

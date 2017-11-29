class AddClaimsUrlToBranchOfServiceContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :branch_of_service_contacts, :claims_url, :text
  end
end

class AddBranchOfServiceToBranchOfServiceContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :branch_of_service_contacts, :branch_of_service, foreign_key: true
  end
end

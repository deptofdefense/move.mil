class AddPpmContactsToBranchOfServiceContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :branch_of_service_contacts, :ppm_website, :text
    add_column :branch_of_service_contacts, :ppm_tel_comm, :text
  end
end

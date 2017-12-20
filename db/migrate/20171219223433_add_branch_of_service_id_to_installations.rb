class AddBranchOfServiceIdToInstallations < ActiveRecord::Migration[5.1]
  def change
    add_reference :installations, :branch_of_service, foreign_key: true
  end
end

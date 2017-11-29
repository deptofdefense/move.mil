class AddBranchOfServiceToServiceSpecificPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :service_specific_posts, :branch_of_service, foreign_key: true
  end
end

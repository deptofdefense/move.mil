class RemoveBranchFromServiceSpecificPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :service_specific_posts, :branch, :text
  end
end

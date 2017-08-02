class CreateServiceSpecificPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :service_specific_posts do |t|
      t.text :title
      t.date :effective_at
      t.text :branch
      t.text :content

      t.timestamps
    end
  end
end

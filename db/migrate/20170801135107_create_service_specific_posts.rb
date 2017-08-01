class CreateServiceSpecificPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :service_specific_posts do |t|
      t.text :title
      t.date :effective
      t.text :content
      t.string :branch

      t.timestamps
    end
  end
end

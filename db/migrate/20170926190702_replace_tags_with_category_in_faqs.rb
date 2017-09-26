class ReplaceTagsWithCategoryInFaqs < ActiveRecord::Migration[5.1]
  def change
    remove_column :faqs, :tags, :text, array: true, default: []
    add_column :faqs, :category, :text
  end
end

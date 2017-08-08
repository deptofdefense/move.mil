class AddSlugToTutorials < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorials, :slug, :text

    Tutorial.find_each(&:save!)

    change_column_null :tutorials, :slug, false
  end
end

class CreateTutorialSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :tutorial_steps do |t|
      t.references :tutorial, foreign_key: true
      t.text :content, null: false
      t.text :image_path, null: true

      t.timestamps
    end
  end
end

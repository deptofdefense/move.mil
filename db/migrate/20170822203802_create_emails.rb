class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.references :office, polymorphic: true
      t.text :name
      t.text :address

      t.timestamps
    end
  end
end

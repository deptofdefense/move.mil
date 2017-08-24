class CreatePhones < ActiveRecord::Migration[5.1]
  def change
    create_table :phones do |t|
      t.references :office, polymorphic: true
      t.text :name
      t.text :tel
      t.text :fax
      t.text :tel_dsn
      t.text :fax_dsn
      t.text :notes

      t.timestamps
    end
  end
end

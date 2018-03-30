class CreateZipcodeAndStateModels < ActiveRecord::Migration[5.1]
  def self.up
    # Zipcodes Table
    create_table :zipcodes do |t|
      t.string :code
      t.string :city
      t.integer :state_id
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lon, :precision => 15, :scale => 10
      t.timestamps
    end
    add_index :zipcodes, :code
    add_index :zipcodes, :state_id
    add_index :zipcodes, [:lat, :lon]

    # States Table
    create_table :states do |t|
      t.string :abbr, :limit => 2
      t.string :name
      t.timestamps
    end
    add_index :states, :abbr
  end

  def self.down
    drop_table :states
    drop_table :zipcodes
  end
end

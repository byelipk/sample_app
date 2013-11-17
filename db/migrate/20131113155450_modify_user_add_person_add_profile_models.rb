class ModifyUserAddPersonAddProfileModels < ActiveRecord::Migration 
  def change
  	remove_column :users, :first_name
  	remove_column :users, :last_name
  	
  	create_table :people do |t|
      t.integer :user_id
      t.timestamps
  	end

  	add_index :people, :user_id, :unique => true

  	create_table :profiles do |t|
      t.string :first_name, :limit => 127
      t.string :last_name, :limit => 127
      t.date :birthday
      t.string :gender
      t.boolean :searchable, :default => true
      t.integer :person_id
      t.timestamps
  	end

    add_index :profiles, [:first_name, :searchable]
    add_index :profiles, [:last_name, :searchable]
    add_index :profiles, [:first_name, :last_name, :searchable]
    add_index :profiles, :person_id
  end

end
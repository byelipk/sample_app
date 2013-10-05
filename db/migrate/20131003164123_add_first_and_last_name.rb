class AddFirstAndLastName < ActiveRecord::Migration
  def change
  	rename_column :users, :name, :first_name
  	add_column :users, :last_name, :string, :after => :first_name
  end
end

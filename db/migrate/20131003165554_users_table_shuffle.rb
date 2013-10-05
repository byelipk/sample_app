class UsersTableShuffle < ActiveRecord::Migration
  def change
  	drop_table :users
  	
  	create_table "users", :force => true do |t|
	    t.string   "first_name"
	    t.string   "last_name"
	    t.string   "email"
	    t.string   "password_digest"
	    t.string   "remember_token"
	    t.boolean  "admin",           :default => false
	    t.boolean  "active",          :default => false
	    t.boolean  "verified_email",  :default => false   
	   	t.datetime "created_at",      :null => false
	    t.datetime "updated_at",      :null => false 
  	end
  	add_index :users, :email, unique: true
  	add_index :users, :remember_token
  	add_index :users, :first_name
  	add_index :users, :last_name
  end
end

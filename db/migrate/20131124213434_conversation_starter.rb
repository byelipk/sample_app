class ConversationStarter < ActiveRecord::Migration
  def change
  	create_table :conversations do |t|
  		t.string  	 :title, null: false
  		t.integer 	 :person_id, null: false         # author
  		t.timestamps
  	end

    add_index :conversations, :person_id

  	create_table :posts do |t|
  		t.integer 	  :person_id, null: false        
  		t.integer 	  :conversation_id, null: false  # parent conversation
      t.integer     :previous_post                 # id of previous post     
  		t.text		    :content, null: false
  		t.timestamps
  	end

    add_index :posts, :person_id
    add_index :posts, :conversation_id
    add_index :posts, :previous_post


  	create_table :post_actions do |t|              # response type lookup table
      t.integer     :post_id, null: false
      t.integer     :person_id, null: false                  
  		t.integer     :post_type_id, null: false 
  		t.timestamps
  	end

    add_index :post_actions, :post_id
    add_index :post_actions, :person_id
    add_index :post_actions, :post_type_id

  	create_table :post_types do |t|                # table to store response actions   
      t.string    :name_key, null: false
  		t.timestamps
  	end    

    create_table :participations do |t|
      t.integer     :person_id, null: false
      t.integer     :conversation_id, null: false
      t.timestamps
    end

    add_index :participations, :person_id
    add_index :participations, :conversation_id 
    add_index :participations, [:person_id, :conversation_id], unique: true   

    create_table :subscriptions do |t|
      t.integer     :person_id, null: false
      t.integer     :conversation_id, null: false
      t.timestamps
    end

    add_index :subscriptions, :person_id
    add_index :subscriptions, :conversation_id
    add_index :subscriptions, [:person_id, :conversation_id], unique: true
  end
end

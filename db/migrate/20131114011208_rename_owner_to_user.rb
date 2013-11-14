class RenameOwnerToUser < ActiveRecord::Migration
  def change
  	rename_column :people, :owner_id, :user_id
  end
end

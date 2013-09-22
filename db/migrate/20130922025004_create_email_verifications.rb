class CreateEmailVerifications < ActiveRecord::Migration
  def change
    create_table :email_verifications do |t|
      t.integer :user_id
      t.string :code

      t.timestamps
    end
    add_index :email_verifications, :code
  end
end

class AddBoolToEmailVerifications < ActiveRecord::Migration
  def change
  	add_column :email_verifications, :active_link, :boolean, default: true
  end
end

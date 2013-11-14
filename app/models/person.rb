# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ActiveRecord::Base
	
	has_one :profile, :dependent => :destroy

	delegate :first_name, :last_name, :full_name, to: :profile
	accepts_nested_attributes_for :profile

	belongs_to :user

end

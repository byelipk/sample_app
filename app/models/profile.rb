# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string(127)
#  last_name  :string(127)
#  birthday   :date
#  gender     :string(255)
#  searchable :boolean          default(TRUE)
#  person_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	
	belongs_to :person

	before_save do 
	  first_name.capitalize!
	  last_name.capitalize!
	end 

	def full_name
		"#{first_name} #{last_name}"
	end

end

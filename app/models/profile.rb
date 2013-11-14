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
	attr_accessible :first_name, :last_name

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	
	belongs_to :person

	def full_name
		self.first_name + " " + self.last_name
	end

end

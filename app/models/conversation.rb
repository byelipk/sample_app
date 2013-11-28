# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base

	# -- ASSOCIATIONS
	belongs_to :starter, class_name: "Person", foreign_key: "person_id"

	has_many :posts

	# -- VALIDATIONS
	validates :title, presence: true

	def setup_first_post
		self.posts.build(person_id: self.starter.id)
	end

end
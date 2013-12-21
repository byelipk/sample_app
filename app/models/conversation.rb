# == Schema Information
#
# Table name: conversations
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  person_id     :integer          not null
#  first_post_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Conversation < ActiveRecord::Base

	# -- ASSOCIATIONS
	belongs_to :starter, class_name: "Person", foreign_key: "person_id"

	has_many :posts

	# -- VALIDATIONS
	validates :title, presence: true, length: { maximum: 140 }

	def setup_first_post
		self.posts.build(person_id: self.starter.id)
	end

	def set_first_post(post_id)
		self.first_post_id = post_id
		self.save!
	end

	def most_recent_post(post)
		self.posts.index(post) + 1
	end

end

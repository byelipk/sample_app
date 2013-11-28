# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  person_id       :integer          not null
#  conversation_id :integer          not null
#  previous_post   :integer
#  content         :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Post < ActiveRecord::Base
	
	belongs_to :author, class_name: "Person", foreign_key: "person_id"
	belongs_to :conversation

end

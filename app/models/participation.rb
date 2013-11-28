# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  person_id       :integer          not null
#  conversation_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Participation < ActiveRecord::Base

	belongs_to :person
	belongs_to :conversation

end

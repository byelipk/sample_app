# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string(100)
#  last_name  :string(100)
#  birthday   :date
#  gender     :string(255)
#  searchable :boolean          default(TRUE)
#  person_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name

	belongs_to :person



end

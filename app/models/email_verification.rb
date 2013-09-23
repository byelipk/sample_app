# == Schema Information
#
# Table name: email_verifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmailVerification < ActiveRecord::Base
	# Associations
  	belongs_to :user

  	# Validations
  	validates :user_id, presence: true
  	validates :code, presence: true

  	# Callbacks
  	before_validation :make_code, on: :create
  	after_create :send_verification_email

	private
	  	
	  	def make_code
	  		self.code = SecureRandom.urlsafe_base64(22)
	  	end

	  	def send_verification_email
	  		UserMailer.email_verification(self).deliver
	  	end
end

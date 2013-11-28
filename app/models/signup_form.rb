class SignupForm
	# -- ActiveModel FUNCTIONALITY
	extend ActiveModel::Naming
	include ActiveModel::Conversion
	include ActiveModel::Validations

	def self.model_name
		ActiveModel::Name.new(self, nil, "User")
	end

	def persisted?
		false
	end

	# -- VALIDATIONS
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
	                    format:   { with: VALID_EMAIL_REGEX }
	validate  :verify_unique_email
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	delegate :email, :password, :password_confirmation, to: :user
	delegate :first_name, :last_name, to: :profile
	
	# -- INSTANCE METHODS	

	def initialize(user_params={}, profile_params={})
		@user_params    = user_params
		@profile_params = profile_params
	end

	def user
		@user    ||= User.new(@user_params)
	end

	def profile
		@profile ||= user.build_associations(@profile_params)
	end

	def submit(user_params, profile_params)
		user.attributes    = user_params
		profile.attributes = profile_params
		if valid?
			user.save!
			profile.save!
			true
		else
			false
		end
	end
	
	def verify_unique_email
		if User.exists? email: user.email
			errors.add :email, "has already been taken"
		end
	end
end
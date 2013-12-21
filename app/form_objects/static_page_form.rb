class StaticPageForm < BaseForm

	def self.model_name
		ActiveModel::Name.new(self, nil, "User")
	end	

	delegate :email, :password, to: :user
	delegate :first_name, :last_name, to: :profile	

	# -- INSTANCE METHODS	

	def user
		@user    ||= User.new
	end

	def profile
		@profile ||= user.build_associations
	end	

end
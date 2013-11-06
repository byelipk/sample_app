class UserActivation
	attr_reader :user

	def initialize(user)
		@user = user
	end

	def activate
		make_active
		verify_email
		@user.save(validate: false)
	end

	def make_active
	    @user.active = true; 
    end

    def verify_email
    	@user.verified_email = true
    end

    def activated?
	    @user.active?
    end
end
class UserActivation
	attr_reader :user

	def initialize(user)
		@user = user
	end

	def activate_account
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

    def account_activated?
	    @user.active?
    end
end
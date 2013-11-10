class SessionsController < ApplicationController
	
	def new
		@user = User.new
	end	

	def create
		reset_session
		user = User.find_by_email(params[:user][:email].downcase)
		if user && user.authenticate(params[:user][:password])
			sign_in user
			if signed_in?
				redirect_back_or root_url, notice: "Sign in successful"
			else			
				session[:lock] = { value: SecureRandom.urlsafe_base64(20) }
				redirect_back_or( resend_activation_url )
			end
		else
			@user = User.new
			flash.now[:error] = "Whoops! Make sure your email/password combo is correct"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url, notice: "Sign out successful"
	end
end
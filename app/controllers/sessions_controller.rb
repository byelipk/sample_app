class SessionsController < ApplicationController
	
	def create
		reset_session
		user = User.find_by_email(params[:email].downcase)
		if user && user.authenticate(params[:password])
			sign_in user
			if signed_in?
				redirect_back_or root_url
			else
				redirect_back_or activate_url
				session[:lock] = { value: SecureRandom.urlsafe_base64(20) }
			end
		else
			flash.now[:error] = "Whoops! Make sure your email/password combo is correct."
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end

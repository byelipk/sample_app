class SessionsController < ApplicationController
	
	def new
		@user = User.new
	end	

	def create
		reset_session
		user = User.find_by_email(params[:user][:email].downcase)
		if user && user.authenticate(params[:user][:password])		
			if sign_in user
				redirect_back_or root_url, notice: "Sign in successful"
			else			
				redirect_back_or root_url, notice: "Please confirm your account by clicking on the link sent to your email."
			end
		else
			@user = User.new
			flash.now[:error] = "Invalid email or password."
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url, notice: "Sign out successful"
	end
end
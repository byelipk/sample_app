class AccountConfirmationsController < ApplicationController

	def new
	    if session[:email]
	    	@email = session[:email]
	    	reset_session
	    else
	    	redirect_to signup_url 
	    end
	end

	def edit
		@user = User.find_by_confirmation_token!(params[:id])
		@user.activate_account 
	    sign_in(@user)
	    flash[:success] = "Welcome to kshizzy, #{@user.person.full_name}!"
	    redirect_to root_url 		
	end
end
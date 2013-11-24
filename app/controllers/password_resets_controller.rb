class PasswordResetsController < ApplicationController

	# -- PRIVATE METHODS
	before_filter :email_params, only: :create
	before_filter :id_params, only: [:edit, :update]
	before_filter :password_params, only: :update

	def new

	end

	def create 
		user = User.find_by_email( email_params )
		user.send_password_reset if user
		redirect_to root_url, notice: "Email sent with password reset instructions."
	end

	def edit
		@user = User.find_by_password_reset_token!( id_params )
	end

	def update
	  @user = User.find_by_password_reset_token!( id_params )
	  if @user.password_reset_sent_at < 1.hour.ago
	    redirect_to new_password_reset_path, :alert => "Password reset has expired."
	  elsif @user.update_attributes( password_params )
	    redirect_to root_url, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
	end	

	private

	def email_params
		permitted = params.permit(:email)
		permitted[:email]
	end

	def id_params
		permitted = params.permit(:id)
		permitted[:id]
	end

	def password_params
		params[:user].permit(:password, :password_confirmation)
	end

end
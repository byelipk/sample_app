class UserVerificationsController < ApplicationController
	before_filter :valid_verify_attempt?, only: :verify
	before_filter :get_user_id_from_session, only: :activate

	def verify
	    @verification.deactivate	
	    session[:user_id] = @verification.user_id
	    redirect_to action: :activate	
	end

	def activate
	    @user.activate      
	    sign_in(@user)
	    flash[:success] = "Welcome to kshizzy, #{@user.person.full_name}!"
	    redirect_to root_url 
	end

	def resend_activation
	    # to send a new activation link
	    if session[:lock]
	      @user = User.new
	      reset_session	      
	    else
	      redirect_to signup_url
	    end
	end

  	def resend
    	# user filled out request to send new activation link
    	@user = User.find_by_email(params[:user][:email])
	    
	    redirect_to signup_url if @user.nil?
	    
	    e = @user.email_verifications.pop
	    e.deactivate
	    @user.email_verifications.create!
	    session[:email] = @user.email
	    redirect_to action: :thank_you
  	end	

	def thank_you
	    # Direct user to their email to finalize sign-up
	    if session[:email]
	    	@email = session[:email]
	    	reset_session
	    else
	    	redirect_to signup_url 
	    end
    end  

    private

    def valid_verify_attempt?
		@verification = EmailVerification.find_by_code(params[:id])	    
	    if @verification.nil? || !@verification.active_link?
	      	redirect_to root_url  
	    else	
	    	@verification
	    end
    end	

    def get_user_id_from_session
    	if session[:user_id]
    		@user = User.find(session[:user_id])
    		reset_session
    		@user 
    	else
    		redirect_to signup_url
    	end
    end
end
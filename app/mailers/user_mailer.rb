class UserMailer < ActionMailer::Base
  default from: "confirm@kshizzy.com"

  def account_confirmation( user )
  	@user = user
    # Production URL
  	# @url = "#{PROD_SERV}/account_confirmations/#{@user.confirmation_token}/edit"

  	# Dev URL 
  	@url = "http://localhost:3000/account_confirmations/#{@user.confirmation_token}/edit"
  	mail(to: @user.email, subject: 'Confirm your Kshizzy account')
  end

  def password_reset( user )
    @user = user 
    # Production URL
    #@url = "https://sheltered-reaches-8554.herokuapp.com/password_resets/#{@user.password_reset_token}/edit"    
    
    # Dev URL
    @url  = "http://localhost:3000/password_resets/#{@user.password_reset_token}/edit"
    mail(to: @user.email, from: 'account@kshizzy.com' , subject: 'Password reset')
  end
end
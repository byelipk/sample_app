class UserMailer < ActionMailer::Base
  default from: "confirm@kshizzy.com"

  def email_verification(verify)
  	@user = verify.user
  	@code = verify.code

  	# Production URL
  	#@url = "https://sheltered-reaches-8554.herokuapp.com/confirm/email/#{@code}"

  	# Dev URL
  	@url = "http://localhost:3000/confirm/email/#{@code}"
  	mail(to: @user.email, subject: 'Confirm your Kshizzy account')
  end
end

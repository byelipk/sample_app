class UserMailer < ActionMailer::Base
  default from: "confirm@kshizzy.com"

  def email_verification(verify)
  	@user = verify.user
  	@code = verify.code
  	#@url = "https://sheltered-reaches-8554.herokuapp.com/users/verify/#{@code}"
  	@url = "http://localhost:3000/users/verify/#{@code}"
  	mail(to: @user.email, subject: 'Confirm your Kshizzy account')
  end
end

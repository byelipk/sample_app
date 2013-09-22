class UserMailer < ActionMailer::Base
  default from: "pat@kshizzy.com"

  def email_verification(verified)
  	@user = verified.user
  	@code = verified.code
  	@url = "https://sheltered-reaches-8554.herokuapp.com/users/verify/#{@code}"
  	#@url = "http://localhost:3000/users/verify/#{@code}"
  	mail(to: @user.email, subject: 'Velcom to Kshizzy!')
  end
end

class RegistrationNotification < ActionMailer::Base
  default from: "byelipk@gmail.com"

  def welcome_email(user)
  	@user = user
  	@url = 'https://sheltered-reaches-8554.herokuapp.com/signin'
  	mail(to: @user.email, subject: 'Velcom to Kshizzy!')
  end
end

class UserMailer < ApplicationMailer
  default from: 'notifications@odinfacebook.com'

  def welcome_email(user)
    @user = user
    @url = 'http://odinfacebook.placeholder.com'
    mail(to: @user.email, subject: "Welcome to Odin Facebook!")
  end
end

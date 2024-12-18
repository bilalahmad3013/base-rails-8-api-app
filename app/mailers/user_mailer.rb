class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @confirmation_link = confirmation_url(token: @user.confirmation_token)
    mail(to: @user.email_address, subject: 'Please confirm your email address')
  end
end

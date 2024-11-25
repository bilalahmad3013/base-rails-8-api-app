class PasswordsMailer < ApplicationMailer
  def reset(user:, token:)
    @user = user
    @reset_root = ENV['RESET_PASSWORD_ROOT']
    @reset_url ="#{@reset_root}?email_address=#{user.email_address}&token=#{token}"
    mail subject: "Reset your password", to: user.email_address
  end
end

#frozen_string_literal: true
class PasswordController < ApplicationController
  def forgot_password
    @user = User.find_by(email_address: params[:email_address]);
    if @user
      raw_token = SecureRandom.hex(10)
      hashed_token = BCrypt::Password.create(raw_token)
      @user.update_columns(
        reset_password_token: hashed_token,
        reset_password_sent_at: Time.current
      )
      PasswordsMailer.reset(user: @user, token: raw_token).deliver_now
      render_success(message: "Password reset link sent successfully")
    else
      render_failure(message: "No user found with this email")
    end
  end

  def reset_password
    @user = User.find_by(email_address: params[:email_address])
    if @user && valid_token?(@user, params[:token]) && params[:new_password] === params[:confirm_password]
      @user.update(password: params[:new_password])
      render_success(message: "Password updated successfully")
    else
      render_failure(message: "Validation failed")
    end
  end

  private

  def valid_token?(user, token)
    BCrypt::Password.new(user.reset_password_token) == token &&
      user.reset_password_sent_at > 10.minutes.ago
  end
end

class UserController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    @user = User.new(user_params)

    if @user.save
      render_success(message: 'Account created successfully')
    else
      render_failure(message: @user.errors.full_messages)
    end
  end

  def destroy
    if @current_user&.destroy
      render_success(message: 'Account deleted successfully')
    else
      render_failure(message: current_user&.errors&.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email_address,
      :password,
      user_profile_attributes: [:first_name, :last_name, :avatar]
    )
  end
end

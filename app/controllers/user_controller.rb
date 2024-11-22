class UserController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)

      if @user.save
        create_user_profile
      else
        raise ActiveRecord::Rollback
      end
    end

    if @user.persisted? && @user.user_profile.persisted?
      render_success(message: 'Account create successfully')
    else
      render_failure(message: @user.errors.full_messages + @user.user_profile.errors.full_messages)
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

  def create_user_profile
    @user_profile = @user.build_user_profile(user_profile_params)

    if @user_profile.save
      Rails.logger.info "User profile created successfully for user #{@user.id}"
    else
      Rails.logger.error "Failed to create user profile for user #{@user.id}: #{@user_profile.errors.full_messages.join(', ')}"
      raise ActiveRecord::Rollback
    end
  end

  def user_params
    params.require(:user).permit(:email_address, :password)
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :bio)
  end
end

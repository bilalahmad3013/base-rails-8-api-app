class UserController < ApplicationController
  before_action :authorize_request, except: [:create, :confirm, :find_user]

  def create
    ActiveRecord::Base.transaction do
      @user = User.new(user_params)

      if @user.save
        workspace = @user.workspaces.new(workspace_params)

        if workspace.save
          render_success(message: 'Account and workspace created successfully')
        else
          render_failure(message: workspace.errors.full_messages[0])
        end
      else
        render_failure(message: @user.errors.full_messages[0])
      end
    end
  rescue ActiveRecord::Rollback => e
    render_failure(message: e.message)
  end

  def find_user
    email_address = user_find_params[:email_address]
    user = BLOOM_FILTER.possibly_contains?(email_address)
    if !user.nil?
      user = User.find_by(email_address: email_address)
      if user
        encrypted_data = encode_user_id(user.id)
        render_success(data: encrypted_data, message: 'User found!')
      else
        render_failure(message: 'User not found')
      end
    else
      render_failure(message: 'User not found')
    end
  end

  def update
    if @current_user && @current_user.update(user_params)
      render_success(message: 'Account updated successfully')
    end
  end

  def destroy
    if @current_user && @current_user.destroy
      render_success(message: 'Account deleted successfully')
    else
      render_failure(message: 'Not Authorize to delete this account.')
    end
  end

  def confirm
    user = User.find_by(confirmation_token: params[:token])
    if user && !user.confirmation_expired?
      user.confirm!
      redirect_to "#{ENV['FRONTEND_URL']}?confirmation_status=true", allow_other_host: true
    else
      redirect_to "#{ENV['FRONTEND_URL']}?confirmation_status=true", allow_other_host: true
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

  def workspace_params
    params[:user][:workspaces_attributes].permit(:name, :description)
  end

  def user_find_params
    params.permit(:email_address)
  end
end

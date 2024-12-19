class UserController < ApplicationController
  before_action :authorize_request, except: [:create, :confirm]

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
      redirect_to "#{ENV['FRONTEND_URL']}?confirmation_status=true"
    else
      redirect_to "#{ENV['FRONTEND_URL']}?confirmation_status=true"
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
end

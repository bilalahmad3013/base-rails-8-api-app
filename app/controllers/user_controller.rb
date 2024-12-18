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
          raise ActiveRecord::Rollback, "Workspace creation failed: #{workspace.errors.full_messages.join(', ')}"
        end
      else
        raise ActiveRecord::Rollback, "User creation failed: #{@user.errors.full_messages.join(', ')}"
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
    end  
  end
  
  def confirm   
    user = User.find_by(confirmation_token: params[:token])

    if user && !user.confirmation_expired?
      user.confirm!
      render_success(message: 'Account confirmed successfully')      
    else
      render_failure(message: 'Invalid or expired token')
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

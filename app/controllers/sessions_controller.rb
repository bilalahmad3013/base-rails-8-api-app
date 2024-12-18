class SessionsController < ApplicationController
  before_action :authorize_request, except: :create
  def new
  end

  def create
    @user = User.find_by_email_address(params[:user][:email_address])
    if @user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      api_success(data: {token: token, email: @user.email_address}, message:"Session created successfully")
    else
      render_failure(message: "Invalid email address or password.")
    end
  end
end

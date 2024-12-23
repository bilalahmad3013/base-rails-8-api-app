class SessionsController < ApplicationController
  before_action :authorize_request, except: :create
  def new
  end

  def create
    user_id = decode_user_id(params[:user][:encrypted_id])
    @user = User.find(user_id)
    if @user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      api_success(data: {token: token}, message:"Session created successfully")
    else
      render_failure(message: "Invalid email address or password.")
    end
  end
end

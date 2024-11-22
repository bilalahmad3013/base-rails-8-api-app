class ApplicationController < ActionController::API
  include ApiResponseHandler

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render_failure(message: e.message)
    rescue JWT::DecodeError => e
      render_failure(message: e.message)
    end
  end
end

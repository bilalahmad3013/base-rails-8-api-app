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

  def encode_user_id(id)
    crypt = crypt()
    return crypt.encrypt_and_sign(id)
  end

  def decode_user_id(encrypted_id)
    crypt = crypt()
    return crypt.decrypt_and_verify(encrypted_id)
  end

  private

  def crypt
    key = Digest::SHA256.digest(Rails.application.credentials.secret_key_base)
    return ActiveSupport::MessageEncryptor.new(key)
  end
end

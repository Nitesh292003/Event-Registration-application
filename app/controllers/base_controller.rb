class BaseController < ApplicationController
    before_action :authenticate_request
  
    private
  
    def authenticate_request
      token = request.headers['Authorization']&.split(' ')&.last
      puts "Received Token: #{token}" # Log the token to verify
  
      decoded_token = decode_jwt(token)
      @current_user = User.find(decoded_token[:user_id]) if decoded_token
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  
    def decode_jwt(token)
      JWT.decode(
        token,
        Rails.application.credentials.secret_key_base,
        true,
        { algorithm: 'HS256' }
      ).first.symbolize_keys
    end
  
    def current_user
      @current_user
    end
  end
  
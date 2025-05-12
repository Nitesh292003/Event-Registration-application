# frozen_string_literal: true

class SessionsController < BaseController
  skip_before_action :authenticate_request, only: [:create]

  # POST /login
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = @user.jwt_token({ user_id: @user.id })
      render json: { message: 'Login successful', user: @user, token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end

# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
    if user.blank?
      render json: { errors: ['Email not found'] }, status: :not_found
    elsif user.valid_password?(params[:user][:password])
      super
    else
      render json: { error: ['Invalid password']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         }, status: :unauthorized
    end
  end

  private
  def respond_with(current_user, _opts = {})
    render json: {
      code: 200, message: 'Logged in successfully.',
      user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
      role: current_user.role_id
    }, status: :ok
  end
  
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end

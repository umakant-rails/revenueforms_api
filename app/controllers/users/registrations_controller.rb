# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :authenticate_scope!, only: [:update]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    error = []
    user_temp = User.where("email = ? or username = ?", params[:user][:email], params[:user][:username]).first rescue nil
    username = params[:user][:username]

    if user_temp && (user_temp.email == params[:user][:email])
      error.push("Email is already Exist.")
    end
    if user_temp && (user_temp.username == username)
      error.push("Username is already taken.")
    end 
    if username && (username.length < 6 || username.length > 14 )
      error.push("Username length must be between 6 to 14 alphabets.")
    end

    if @user && error
      render json: { user: user_temp, error: error, status: 422 }
    else
      super
    end
  end

  def update
    user = current_user

    unless user.valid_password?(account_update_params[:current_password])
      return render json: { error: "Current password is incorrect" }, status: :unprocessable_entity
    end
  
    if user.update_with_password(account_update_params)
      render json: { message: "Password updated successfully" }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def respond_with(current_user, _opts = {})
    if @user.errors.full_messages.present?
        render json: { 
          action_status: false,
          error: @user.errors.full_messages 
        }
    elsif resource.persisted?
      render json: {
        user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        confirmation_token: resource.confirmation_token,
        message: 'You have signed up sucessfully. You will receive an email with instructions for how to confirm your email address in a few minutes.'
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, :role_id, :email, :password, :password_confirmation
    ])
  end

  # Params permitted during ACCOUNT UPDATE
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :password, :password_confirmation, :current_password
    ])
  end

end

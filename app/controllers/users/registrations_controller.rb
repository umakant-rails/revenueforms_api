# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

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

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        confirmation_token: resource.confirmation_token,
        message: 'You have signed up sucessfully.'
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

end

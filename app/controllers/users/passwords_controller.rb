# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json
  before_action :authenticate_user!
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    @password_action = 'create'
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    if  resource_params[:reset_password_token].present?
      @password_action = 'update_by_token'
      super
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  private
    def respond_with(resource, _opts = {})
      if @user.errors.full_messages.present?
        render json: { 
          action_status: false,
          error: @user.errors.full_messages 
        }
      elsif @user.id.present? && @password_action == 'update_by_token'
        render json: { message: 'Your password has been updated successfully.' }
      elsif @user.id.present? && @password_action == 'create'
        render json: {
          action_status: true,
          message: 'You will receive an email with instructions on how to reset your password in a few minutes.'
        }
      end
    end
    def resource_params
      params.require(:user).permit(:reset_password_token, :password, :password_confirmation, :email)
    end
end

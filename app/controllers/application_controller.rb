class ApplicationController < ActionController::API
  before_action :set_default_response_format
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_csrf_cookie

  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  private

    def set_default_response_format
      request.format = :json
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :role_id, :mobile])
      # devise_parameter_sanitizer.permit(:reset_password, keys: [:reset_password_token, :username, :email])
    end

    def set_csrf_cookie
      cookies["CSRF-TOKEN"] = {
        value: form_authenticity_token,
        domain: :all 
      }
    end
end

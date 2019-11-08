class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:sur_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fr_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:sur_name_yomi])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_yomi])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthday_year])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthday_manth])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthday_day])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tel_number])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account])
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

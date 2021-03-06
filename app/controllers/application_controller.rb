class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :restrict_access, unless: :devise_controller?





  

  protected
  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end

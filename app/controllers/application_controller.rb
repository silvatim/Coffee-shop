class ApplicationController < ActionController::Base # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :password_confirmation)
    devise_parameter_sanitizer.for(:sign_in).push(:first_name, :last_name, :password_confirmation)
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :password_confirmation)
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

end

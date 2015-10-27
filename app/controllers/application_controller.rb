class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def super_user?
   admin_signed_in? && super_user
  end

  def super_user
  	current_admin.god_mode == true
  end

  def require_super_user
  	unless super_user?
  		redirect to root_url, alert: "Unauthorized access!"
  	end
  end

  helper_method :super_user
  helper_method :super_user?
  helper_method :require_super_user

end

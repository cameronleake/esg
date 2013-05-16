class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    if current_user.nil?
      redirect_to root_path, alert: "Not authorized!"
    end
  end
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  helper_method :current_user

end

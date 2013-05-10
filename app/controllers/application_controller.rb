class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    if current_user.nil?
      redirect_to login_url, alert: "Not authorized"
    elsif current_user.email_verified == false
      redirect_to root_url, :alert => "Email address not yet verified!"
    end
  end
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  helper_method :current_user

end

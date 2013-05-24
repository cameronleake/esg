class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :find_navbar_categories


  def authorize_user_logged_in
    if current_user.nil?
      redirect_to root_path, alert: "Not authorized!"
    end
  end
  
  def authorize_email_verified
    if current_user.email_verified == false
      redirect_to profile_path, alert: "Email not verified! Please verify for access to this resource."
    end
  end

  def find_navbar_categories
    @navbar_categories = Category.order("name ASC").find(:all)
  end
  
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

end

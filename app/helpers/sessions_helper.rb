module SessionsHelper
  
  def remember_me(user)
    if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
    else
      cookies[:auth_token] = user.auth_token  
    end
  end
  
  def is_email_verified(user)
    if user.email_verified == false
      redirect_to root_path, :alert => "Email address not yet verified! #{ActionController::Base.helpers.link_to "Click here to send verification email.", sendmessage_email_verification_path(user)}".html_safe
    else
      redirect_to root_path, :notice => "Logged in!"
    end
  end
  
end

module UsersHelper
  
  def is_authorized_to_access(user)
    if user
      redirect_to profile_path
    else
      redirect_to login_path, alert: "Not logged in!"
    end    
  end
  
end

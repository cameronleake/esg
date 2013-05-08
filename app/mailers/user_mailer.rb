class UserMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def welcome_message(user)
    @user = user
    mail :to => user.email, :subject => "Welcome to Engineering Survival Guide"
  end
  
end

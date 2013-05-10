class UserMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def password_reset(user)
    @user = user
    attachments.inline["Email_Header-ESG.jpg"] = File.read("#{Rails.root}/app/assets/images/Email_Header-ESG.jpg")
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def welcome_message(user)
    @user = user
    attachments.inline["Email_Header-ESG.jpg"] = File.read("#{Rails.root}/app/assets/images/Email_Header-ESG.jpg")    
    mail :to => user.email, :subject => "Welcome to Engineering Survival Guide"
  end
  
  def email_verification_message(user)
    @user = user
    attachments.inline["Email_Header-ESG.jpg"] = File.read("#{Rails.root}/app/assets/images/Email_Header-ESG.jpg")    
    mail :to => user.email, :subject => "Email Verification"
  end
  
end

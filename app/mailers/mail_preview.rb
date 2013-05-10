class MailPreview < MailView
  
  def password_reset
    @user = FactoryGirl.build(:user)
    mail = UserMailer.password_reset(@user)
  end
  
  def welcome_message
    @user = FactoryGirl.build(:user)
    mail = UserMailer.welcome_message(@user)
  end
  
  def email_verification_message
    @user = FactoryGirl.build(:user)
    mail = UserMailer.email_verification_message(@user)
  end
  
  def contact_us
    @contact = FactoryGirl.build(:contact)
    mail = ContactMailer.contact_us(@contact)
  end
  
end
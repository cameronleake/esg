require 'spec_helper'
require 'helpers/signup_helper_spec'
require 'helpers/login_helper_spec'

describe "EMAIL VERIFICATION:" do
  context "When creating a new user:" do
    it "Should set Email_Verification and Email_Verification_Token values" do
      @user = FactoryGirl.build(:user)
      signup_new_user(@user.first_name, @user.last_name, @user.email, @user.password)
      current_path.should eq(root_path)
      User.find(:last).email_verified.should be_false
      User.find(:last).email_verification_token.should_not be_nil
      last_email.should have_content(User.find(:last).email_verification_token)
    end
    
    it "Should set EMAIL_VERIFIED attribute to TRUE when clicking email verification link" do
      @user = FactoryGirl.create(:user)
      visit "http://localhost:3000/email_verifications/#{@user.email_verification_token}/edit"
      current_path.should eq(root_path)
      User.find(:last).email_verified.should eq(true)
      page.should have_content("email address has been verified")      
    end
  end
  
  context "When Email_Verification is false:" do
    
    before(:all) do
      @user = FactoryGirl.create(:user)
    end

    after(:all) do
      @user.destroy
    end
    
    it "ACCOUNT page displays an alert with a link to send an Email Verification email" do
      login_user(@user.email, @user.password)
      page.should have_content("Email address not yet verified")   
    end
    
    it "Clicking Send Verification Email sends email to user" do
       login_user(@user.email, @user.password)
       click_link "Click here to send verification email."
       current_path.should eq(root_path)
       last_email.to.should include(@user.email)
       last_email.subject.should include("Email Verification")
       last_email.should have_content(@user.email_verification_token)
    end
  end
end
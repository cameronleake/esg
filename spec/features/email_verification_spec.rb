require 'spec_helper'

describe "EMAIL VERIFICATION:" do
  context "When creating a new user:" do
    it "Should set Email_Verification and Email_Verification_Token values" do
      @user = FactoryGirl.build(:user)
      visit signup_path
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => @user.password
      fill_in "user_password_confirmation", :with => @user.password
      click_button "Sign Up"
      pp User.find(:last).email_verified
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
      visit login_path
      fill_in "email", :with => @user.email
      fill_in "password", :with => @user.password
      click_button "Log In"
      page.should have_content("Email address not yet verified")   
      # page.should have_content(sendmessage_email_verification_path(@user)) # ???
    end
    
    it "Clicking Send Verification Email sends email to user" do
       visit login_path
       fill_in "email", :with => @user.email
       fill_in "password", :with => @user.password
       click_button "Log In"
       click_link "Click here to send verification email."
       current_path.should eq(root_path)
       last_email.to.should include(@user.email)
       last_email.subject.should include("Email Verification")
       last_email.should have_content(@user.email_verification_token)
    end
  end
end
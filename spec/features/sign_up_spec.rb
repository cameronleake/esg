require 'spec_helper'

describe "SIGN UP:" do
  context "When sending Welcome Email:" do
    it "Sends email with verification link" do
      @user = FactoryGirl.build(:user)
      visit signup_path
      fill_in "user_first_name", :with => @user.first_name
      fill_in "user_last_name", :with => @user.last_name
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => @user.password
      fill_in "user_password_confirmation", :with => @user.password
      click_button "Sign Up"
      last_email.to.should include(@user.email)
      last_email.subject.should include("Welcome")
      last_email.should have_content(User.find(:last).email_verification_token)
    end
  end
  
end
require 'spec_helper'

describe "SIGN UP:" do
  context "When sending Welcome Email:" do
    it "Sends email with verification link" do
      @user = FactoryGirl.build(:user)
      visit signup_path
      fill_in "user_email", :with => @user.email
      fill_in "user_password", :with => @user.password
      fill_in "user_password_confirmation", :with => @user.password
      click_button "Sign Up"
      pp @user.email
      pp last_email.to
      last_email.to.should include(@user.email)
      last_email.subject.should include("Welcome")
    end
  end
  
end
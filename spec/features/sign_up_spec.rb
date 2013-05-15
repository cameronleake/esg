require 'spec_helper'
require 'helpers/signup_helper_spec'

describe "SIGN UP:" do
  context "When sending Welcome Email:" do
    it "Sends email with verification link" do
      @user = FactoryGirl.build(:user)
      signup_new_user(@user.first_name, @user.last_name, @user.email, @user.password)
      last_email.to.should include(@user.email)
      last_email.subject.should include("Welcome")
      last_email.should have_content(User.find(:last).email_verification_token)
    end
  end
  
end
require 'spec_helper'

describe "MODEL >> send_password_resets:" do
  let(:user) { FactoryGirl.build(:user) }
    
  it "Generates a unique password_reset_token each time" do
    user.send_password_reset
    last_token = user.password_reset_token
    user.send_password_reset
    user.password_reset_token.should_not eq(last_token)
  end
    
  it "Saves the time the password reset was sent" do
    user.send_password_reset
    user.reload.password_reset_sent_at.should be_present
  end
  
  it "Deliveres email to user" do
    user.send_password_reset
    last_email.to.should include(user.email)
  end
end

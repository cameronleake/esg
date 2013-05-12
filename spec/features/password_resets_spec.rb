require 'spec_helper'

describe "PASSWORD RESETS:" do

  before(:each) do
    @user = FactoryGirl.build(:user)
    @user.password_reset_token = "123456"
    @user.save!
  end
  
  after(:each) do
    @user.destroy
  end

  context "When requesting password reset:" do
    it "Emails user with reset link", focus: true do
      visit login_path
      click_link "Reset"
      fill_in "Email", :with => @user.email
      click_button "Reset"
      current_path.should eq(root_path)
      page.should have_content("Email sent")
      last_email.to.should include(@user.email)
    end

    it "Does not email invalid user when requesting password reset" do
      visit login_path
      click_link "Reset"
      fill_in "Email", :with => "nobody@example.com"
      click_button "Reset"
      current_path.should eq(password_resets_path)
      page.should have_content("Email address not found")
      last_email.should be_nil
    end
  end
  
  context "When resetting password:" do
    it "Saves new matching password to the database" do
      @user.password_reset_sent_at = Time.now
      @user.save
      @old_password = @user.password_digest
      visit edit_password_reset_url(@user.password_reset_token)
      fill_in "user_password", :with => "New_Password"
      fill_in "user_password_confirmation", :with => "New_Password"
      click_button "Update"
      current_path.should eq(root_path)
      @new_password = User.first.password_digest
      @new_password.should_not eq(@old_password)
    end
    
    it "Raises an error if password field is blank" do
      @user.password = SecureRandom.urlsafe_base64
      @user.send_password_reset
      visit edit_password_reset_url(@user.password_reset_token)
      click_button "Update"
      current_path.should eq("/password_resets/#{@user.password_reset_token}")
      page.should have_content("Incorrect password")
    end
  end
end
require 'spec_helper'
require 'helpers/login_helper_spec'

describe "USER PROFILE:" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  
  after(:each) do
    @user.destroy
  end
  
  before :each do
    login_user(@user.email, @user.password)
  end
  
  context "User Details:" do
    it "Does not allow any fields to be left blank" do
      visit profile_path
      fill_in "user_first_name", :with => ""
      fill_in "user_last_name", :with => ""
      fill_in "user_email", :with => ""
      click_button "Save Changes"
      page.should have_content("can't be blank")
    end
    
    it "Displays an email verification link if email not verified" do
      visit profile_path
      page.should have_content ("Send Verification Email")
    end
    
    it "Requests a new email verification if the email is changed" do
      @user.email_verified = true
      @user.save!
      visit profile_path
      page.should_not have_content("Send Verification Email")
      fill_in "user_email", :with => "new_email@example.com"
      click_button "Save Changes"
      page.should have_content("Send Verification Email")
    end
  end

  context "Avatar:" do
    it "Successfully uploads allowable file types" do
      visit profile_path
      path = File.join(::Rails.root, "/public/test_uploads/Default_Profile_Icon.jpg")
      attach_file("user_avatar", path)
      click_button "Save Changes"
      page.should_not have_content("Invalid file type")
    end
    
    it "Does not allow upload of invalid file types" do
      visit profile_path
      path = File.join(::Rails.root, "/public/test_uploads/test.txt")
      attach_file("user_avatar", path)
      click_button "Save Changes"
      page.should have_content("Invalid file type")
    end
    
    it "Displays a default image if none has been uploaded" do
      visit profile_path
      page.should have_xpath('//img[@src="/assets/fallback/profile_Default_Profile_Icon.jpg"]')
    end
  end
end
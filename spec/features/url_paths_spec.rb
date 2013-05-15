require 'spec_helper'
require 'helpers/login_helper_spec'

describe "ACCESS TO DATABASE VIA DIRECT URL PATHS:" do

  before(:all) do
    @user = FactoryGirl.create(:user)
  end
  
  after(:all) do
    @user.destroy
  end

  context "When logged in:" do
    it "INDEX page for USERS redirects to SHOW page for current_user" do
      login_user(@user.email, @user.password)
      visit '/users'
      page.should have_content("Profile")
      page.should have_content(@user.email)
    end
  
    it "Cannot access other USER's SHOW page - Redirects to CURRENT_USER PROFILE" do
      @user2 = FactoryGirl.create(:user)
      test_id = @user2.id
      login_user(@user.email, @user.password)
      visit "/users/#{test_id}"
      page.should have_content("Profile")
      page.should have_no_content(@user2.email)
    end
  end
end

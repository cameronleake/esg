require 'spec_helper'
require 'helpers/login_helper_spec'


describe "REVIEWS:" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:category)
    @resource = FactoryGirl.create(:resource, :category => @category)
    login_user(@user.email, @user.password)
  end
  
  after(:each) do
    @user.destroy
    @category.destroy
    @resource.destroy    
  end
  
  context "When submitting a Resource Review:" do
    
    it "Saves a valid review" do
      visit category_resource_path(@category, @resource)
      fill_in "review_title", :with => "Test Review Title"
      fill_in "review_body", :with => "Test Review Body"
      click_button "Submit"
      Review.last.title.should eq("Test Review Title")
      Review.last.body.should eq("Test Review Body")
    end    
    
    it "Does not savea a Review with blank fields" do
      visit category_resource_path(@category, @resource)
      click_button "Submit"
      Review.last.should eq(nil)
    end
  end
end
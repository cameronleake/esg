require 'spec_helper'
require 'helpers/login_helper_spec'


describe "SHOPPING CART:" do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_user(@user.email, @user.password)
  end
  
  after(:each) do
    @user.destroy
  end
  
  context "When viewing the cart show page:" do
    
    it "User can remove items from the cart" do
      @category = FactoryGirl.create(:category)
      @resources = []
      3.times do
        @resources << FactoryGirl.create(:resource, :category => @category)
      end
      
      @resources.each do |resource|
        visit category_resource_path(resource.category_id, resource.id)
        click_link("Add to Cart")
      end
      
      @cart = ShoppingCart.where(:user_id => @user.id).last
      @initial_count = @cart.resources.count
      visit shopping_cart_path
      first(:link, "Remove").click
      @final_count = @cart.resources.count
      @initial_count.should eq(@final_count + 1)
    end
  end
  
end
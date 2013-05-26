require 'spec_helper'

describe "SHOPPING CART:" do
  
  before(:all) do
    @cart = FactoryGirl.create(:shopping_cart)
  end
  
  after(:all) do
    @cart.destroy 
  end
  
  context "When viewing the cart show page:" do
    it "User can remove items from the cart" do
      3.times do
        @cart.resources << FactoryGirl.create(:resource)
      end
      @initial_count = @cart.resources.count
      @record_to_delete = Resource.find(:first)
      @cart.resources.delete @record_to_delete    # <TODO> Reference helper method for Shopping Cart Controller
      @final_count = @cart.resources.count
      @initial_count.should eq(@final_count + 1)
    end
  end

end
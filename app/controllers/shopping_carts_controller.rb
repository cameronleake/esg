class ShoppingCartsController < ApplicationController
  before_filter :authorize_user_logged_in, only: [:show, :add_to_cart, :remove_from_cart, :checkout, :process_cart]
  before_filter :authorize_shopping_cart_exists, only: [:show, :add_to_cart, :remove_from_cart, :checkout, :process_cart]
  
  def show
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost(@cart)/100
  end
  
  def add_to_cart
    @user = current_user
    @resource_to_add = Resource.find(params[:id])
    @cart = current_shopping_cart
     if resource_already_in_cart(@resource_to_add, @cart)
      redirect_to shopping_cart_path(@cart), :alert => "Item is already in your cart!"
    else
      @cart.resources << @resource_to_add
      redirect_to shopping_cart_path(@cart), :notice => "Item has been added to your cart!"
    end
  end
  
  def remove_from_cart
    @resource_to_remove = Resource.find(params[:id])
    @cart = current_shopping_cart
    @cart.resources.delete @resource_to_remove
    redirect_to shopping_cart_path, :notice => "Item has been removed from your cart!"
  end
  
  def checkout
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost(@cart)/100
  end
  
  def process_cart
    @user = current_user
    @cart = current_shopping_cart
    # # ---------- Process Payments Here ----------
    # if # Payment is verified
    #   @cart.payment_verified = true
    # end
    # # Generate Download Links, (as Download objects associated with the relevant Shopping Cart model)
    generate_download_links(@cart)
    if @cart.delay.send_download_links_email
      @cart.email_sent = true
    end
    @cart.save
    cookies.delete(:cart_token)
    redirect_to root_path, :notice => "Order Processed.  You will recieve an email with your download links shortly!"
  end
  
  
  private
  
  def resource_already_in_cart(resource_to_add, cart)
    cart.resources.each do |resource|
      return true if resource_to_add.id == resource.id
    end
    return false
  end
  
  def generate_download_links(cart)
    @expiry_time = DateTime.now + DOWNLOAD_EXPIRY_HOURS.hours
    cart.resources.each do |resource|
      cart.downloads << Download.new( :shopping_cart_id => cart.id, 
                                      :resource_id => resource.id, 
                                      :download_token => generate_random_token, 
                                      :expiry_time => @expiry_time)
    end
  end

end
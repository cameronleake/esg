class ShoppingCartsController < ApplicationController
  
  def show
    if current_shopping_cart
      @cart = current_shopping_cart
      @cart_items = @cart.resources
      @total_cost = @cart.total_cart_cost(@cart)/100
    else
      redirect_to login_url, alert: "Not authorized!"
    end
  end
  
  def add_to_cart
    if current_user
      @user = current_user
      @resource_to_add = Resource.find(params[:id])
      if current_shopping_cart
         @cart = current_shopping_cart
      else  
         @cart = create_shopping_cart(@user)
      end
      if resource_already_in_cart(@resource_to_add, @cart)
        redirect_to shopping_cart_path(@cart), :alert => "Item is already in your cart!"
      else
        @cart.resources << @resource_to_add
        redirect_to shopping_cart_path(@cart), :notice => "Item has been added to your cart!"
      end
    else
      redirect_to login_url, alert: "Not authorized!"
    end
  end
  
  def remove_from_cart
    @resource_to_remove = Resource.find(params[:id])
    @cart = current_shopping_cart
    @cart.resources.delete @resource_to_remove
    redirect_to shopping_cart_path, :notice => "Item has been removed from your cart!"
  end
  
  
  private
  
  def create_shopping_cart(user)
    @cart = ShoppingCart.new
    @cart.cart_token = @cart.generate_random_token
    @cart.user = user
    @cart.save
    cookies.permanent[:cart_token] = @cart.cart_token
    @cart
  end
  
  def resource_already_in_cart(resource_to_add, cart)
    cart.resources.each do |resource|
      return true if resource_to_add.id == resource.id
    end
    return false
  end

end
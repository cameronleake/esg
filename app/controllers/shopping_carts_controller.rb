class ShoppingCartsController < ApplicationController
  before_filter :authorize_user_logged_in, only: [:show, :add_to_cart, :remove_from_cart]
  before_filter :authorize_shopping_cart_exists, only: [:show, :add_to_cart, :remove_from_cart]
  

  def show
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100
  end

  
  def add_to_cart
    @user = current_user
    @resource_to_add = Resource.find(params[:id])
    @cart = current_shopping_cart
     if @cart.resource_already_in_cart(@resource_to_add)
      redirect_to shopping_cart_path(@cart), :alert => "Item is already in your cart!"
    else
      @cart.resources << @resource_to_add
      redirect_to shopping_cart_path, :notice => "Item has been added to your cart!"
    end
  end
  

  def remove_from_cart
    @resource_to_remove = Resource.find(params[:id])
    @cart = current_shopping_cart
    @cart.resources.delete @resource_to_remove
    redirect_to shopping_cart_path, :notice => "Item has been removed from your cart!"
  end

end
class SessionsController < ApplicationController
  include SessionsHelper

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      remember_me(@user)
      is_email_verified(@user)
      cookies.delete(:cart_token)
    elsif @user && !@user.authenticate(params[:password])
      flash.now.alert = "Incorrect password."
      render "new"
    else
      flash.now.alert = "Email address not found. Please sign up!"
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    if cookies[:cart_token]
      @cart = ShoppingCart.find_by_cart_token(cookies[:cart_token])
      @cart.status = "Abandoned"
      @cart.save!
      cookies.delete(:cart_token)
    end
    redirect_to root_url, notice: "Logged out!"
  end

end

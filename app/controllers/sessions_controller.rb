class SessionsController < ApplicationController
  include SessionsHelper

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      remember_me(@user)
      is_email_verified(@user)
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
    cookies.delete(:cart_token)
    redirect_to root_url, notice: "Logged out!"
  end

end

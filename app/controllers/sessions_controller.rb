class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token  
      end

      if @user.email_verified == false
        redirect_to root_path, :alert => "Email address not yet verified! #{ActionController::Base.helpers.link_to "Click here to send verification email.", sendmessage_email_verification_path(@user)}".html_safe
      else
        redirect_to root_path, :notice => "Logged in!"
      end
      
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
    redirect_to root_url, notice: "Logged out!"
  end

end

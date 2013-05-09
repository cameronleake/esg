class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.email_verification_token = @user.generate_random_token
    if @user.save
      cookies[:auth_token] = @user.auth_token    # Save new auth_token in a temporary cookie
      @user.send_welcome_email  
      redirect_to root_url, notice: "Welcome to Engineering Survival Guide!"
    else
      flash.now.alert = "Invalid email or password."
      render "new"  
    end
  end
  
end

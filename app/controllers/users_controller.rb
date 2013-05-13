class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def edit
    if current_user
      @user = current_user
    else
      redirect_to login_url, alert: "Not authorized!"
    end
  end
  
  def create
    @user = User.new(params[:user])
    @user.email_verification_token = @user.generate_random_token
    if @user.save
      cookies[:auth_token] = @user.auth_token    # Save new auth_token in a temporary cookie
      @user.delay.send_welcome_email  
      redirect_to root_url, notice: "Welcome to Engineering Survival Guide! Please check your inbox and verify your email address."
    else
      render "new"  
    end
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), notice: 'Profile successfully updated.'
    else
      render action: "edit"
    end
  end
  
end

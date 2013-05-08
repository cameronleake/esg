class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now.alert = "Invalid email address."
      render "new"
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @user.password_required = true
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_path, :notice => "Password has been reset!"
    else
      flash.now.alert = "Invalid password."      
      render :edit
    end
  end

end

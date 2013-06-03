class PasswordResetsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.delay.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now.alert = "Email address not found."
      render "new"
    end
  end

  def edit
    if User.find_by_password_reset_token(params[:id])
      @user = User.find_by_password_reset_token!(params[:id])
    else
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @user.password_required = true
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to login_path, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

end

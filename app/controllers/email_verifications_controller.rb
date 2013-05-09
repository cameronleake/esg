class EmailVerificationsController < ApplicationController
  
  def sendmessage
    @user = User.find_by_id(params[:id])
    # @user.delay.send_verification_email
    @user.send_verification_email    
    redirect_to root_path, :notice => "Verification email sent to: #{@user.email}."
  end
  
  def edit
    @user = User.find_by_email_verification_token!(params[:id])
    @user.update_attribute(:email_verified, true)
    redirect_to root_path, :notice => "Thank you. Your email address has been verified."
  end
  
end

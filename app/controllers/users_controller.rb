class UsersController < ApplicationController
  include UsersHelper
  before_filter :authorize_user_logged_in, only: [:index, :show, :edit, :update]


  def index
    is_authorized_to_access(current_user)
  end

  
  def show
    is_authorized_to_access(current_user)
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    @user.email_verification_token = generate_random_token
    @user.avatar = DEFAULT_AVATAR_PATH
    if @user.save
      cookies[:auth_token] = @user.auth_token
      @user.delay.send_welcome_email  
      redirect_to root_url, notice: "Welcome to Engineering Survival Guide! Please check your inbox and verify your email address."
    else
      render "new"  
    end
  end
  
   
  def edit
    if current_user
      @user = current_user
      @downloads = @user.get_downloads_list
    else
      redirect_to login_url, alert: "Not authorized!"
    end
  end

  
  def update
    @user = current_user
    @current_email = current_user.email
    if @user.update_attributes(params[:user])
      if @user.email != @current_email
        @user.un_verify_email
        @user.delay.send_verification_email   
        flash[:alert] = "You have updated your email address.  Please check your inbox and verify the new email address."
      end
      redirect_to edit_user_path(@user), notice: 'Profile successfully updated.'
    else
      render action: "edit"
    end
  end
  
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :current_shopping_cart
  helper_method :authorize_shopping_cart_exists
  before_filter :find_navbar_categories


  def generate_random_token
    SecureRandom.urlsafe_base64
  end
  
  def authorize_user_logged_in
    if current_user.nil?
      redirect_to login_path, alert: "Please login to proceed."
    end
  end
  
  def authorize_email_verified
    if current_user.email_verified == false
      redirect_to profile_path, alert: "Email not verified! Please verify for access to this resource."
    end
  end

  def find_navbar_categories
    @navbar_categories = Category.order("name ASC").find(:all)
  end
  
  def authorize_shopping_cart_exists
    if current_shopping_cart.nil?
      @cart = ShoppingCart.new(:status => "OPEN")
      @cart.cart_token = generate_random_token
      @cart.user = current_user
      @cart.save
      @cart.order_number = (@cart.id + 100000)
      @cart.save
      cookies.permanent[:cart_token] = @cart.cart_token
    end
  end
  
  
  private
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def current_shopping_cart
    @current_shopping_cart ||= ShoppingCart.find_by_cart_token(cookies[:cart_token]) if cookies[:cart_token]
  end

end

class ShoppingCart < ActiveRecord::Base
  attr_accessible :email_sent, :payment_verified, :user_id, :cart_token, :status, :order_number
  has_and_belongs_to_many :resources
  has_many :downloads
  belongs_to :user


  def total_cart_cost(current_shopping_cart)
    @total_cost = 0
    @cart = current_shopping_cart
    @cart.resources.each do |resource|
      @total_cost += resource.price_in_cents
    end
    @total_cost
  end
  
  def send_download_links_email
    ShoppingCartMailer.download_links_email(self).deliver
  end

end

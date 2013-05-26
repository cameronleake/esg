class ShoppingCart < ActiveRecord::Base
  attr_accessible :email_sent, :payment_verified, :user_id
  has_and_belongs_to_many :resources
  belongs_to :user


  def generate_random_token
    SecureRandom.urlsafe_base64
  end

  def total_cart_cost(current_shopping_cart)
    @total_cost = 0
    @cart = current_shopping_cart
    @cart.resources.each do |resource|
      @total_cost += resource.price_in_cents
    end
    @total_cost
  end

end

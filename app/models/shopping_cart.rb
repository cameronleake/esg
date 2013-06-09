class ShoppingCart < ActiveRecord::Base
  attr_accessible :payment_verified
  attr_accessible :user_id
  attr_accessible :cart_token
  attr_accessible :status
  attr_accessible :purchased_at     
  attr_accessible :order_id
  belongs_to :user
  has_and_belongs_to_many :resources
  has_one :order, :dependent => :destroy
  has_many :downloads, :through => :order
  
  after_create :build_default_order 
  

  def total_cart_cost
    @total_cost = 0
    self.resources.each do |resource|
      @total_cost += resource.price_in_cents
    end
    @total_cost
  end
  
  def resource_already_in_cart(resource_to_add)
    self.resources.each do |resource|
      return true if resource_to_add.id == resource.id
    end
    return false
  end  
  
  
  private
  
  def build_default_order
    @order = Order.new(:shopping_cart_id => self.id)
    @order.save(:validate => false)
    self.order_id = @order.id
    self.save
    true
  end   

end

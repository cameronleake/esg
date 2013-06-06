class ShoppingCart < ActiveRecord::Base
  attr_accessible :email_sent
  attr_accessible :payment_verified
  attr_accessible :user_id
  attr_accessible :cart_token
  attr_accessible :status
  attr_accessible :order_number
  belongs_to :user
  has_and_belongs_to_many :resources
  has_many :downloads, :dependent => :destroy
  has_one :order


  def total_cart_cost
    @total_cost = 0
    self.resources.each do |resource|
      @total_cost += resource.price_in_cents
    end
    @total_cost
  end
  
  def send_download_links_email
    ShoppingCartMailer.download_links_email(self).deliver
  end
  
  def resource_already_in_cart(resource_to_add)
    self.resources.each do |resource|
      return true if resource_to_add.id == resource.id
    end
    return false
  end
  
  def generate_download_links
    @expiry_time = DateTime.now + DOWNLOAD_EXPIRY_HOURS.hours
    self.resources.each do |resource|
      @purchase_price = resource.price_in_cents
      self.downloads << Download.new( :shopping_cart_id => self.id, 
                                      :resource_id => resource.id, 
                                      :download_token => generate_random_token, 
                                      :expiry_time => @expiry_time,
                                      :purchase_price_in_cents => @purchase_price)
    end
    self.save!
  end

end

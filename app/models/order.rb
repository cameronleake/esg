class Order < ActiveRecord::Base
  attr_accessible :shopping_cart_id
  attr_accessible :first_name
  attr_accessible :last_name      
  attr_accessible :email
  attr_accessible :ip_address
  attr_accessible :card_type
  attr_accessible :card_expires_on
  attr_accessible :street1
  attr_accessible :street2
  attr_accessible :city
  attr_accessible :state
  attr_accessible :country
  attr_accessible :zip
  attr_accessible :express_token
  attr_accessible :express_payer_id
  attr_accessible :card_number
  attr_accessible :card_verification 
  attr_accessor :card_number, :card_verification    # This will store these variables in memory, but not the database.
  belongs_to :shopping_cart
  has_many :transactions, :class_name => "OrderTransaction"

  validate :validate_card, :on => :create  
  
  
  def purchase(cart) 
    @cart = cart        
    @price_in_cents = @cart.total_cart_cost   
    response = process_purchase
    transactions.create!(:action => "purchase", :amount => @price_in_cents, :response => response)
    @cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

 
  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
      self.email = details.params["payer"]
      self.street1 = details.params["street1"]
      self.street2 = details.params["street2"]
      self.city = details.params["city_name"]
      self.state = details.params["state_or_province"]
      self.country = details.params["country_name"]
      self.zip = details.params["postal_code"]
    end
  end        
  
 
  def price_in_cents       
    shopping_cart.total_cart_cost
  end


  private     

  def process_purchase            
    if express_token.blank?
      STANDARD_GATEWAY.purchase(@price_in_cents, credit_card, standard_purchase_options)       
    else
      EXPRESS_GATEWAY.purchase(@price_in_cents, express_purchase_options)              
    end
  end                                                                                                                                   
                                                        
  
  def standard_purchase_options
    { :ip => ip_address }
  end                          
  
  
  def express_purchase_options
    { :ip => ip_address,
      :token => express_token,
      :payer_id => express_payer_id }
  end
  
  
  def validate_card
    if express_token.blank? && !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors[:base] << message
      end
    end
  end
  
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
  
end

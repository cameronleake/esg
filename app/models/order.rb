class Order < ActiveRecord::Base
  attr_accessible :shopping_cart_id
  attr_accessible :first_name
  attr_accessible :last_name
  attr_accessible :ip_address
  attr_accessible :card_type
  attr_accessible :card_expires_on
  attr_accessor :card_number, :card_verification    # This will store these variables in memory, but not the database.

  belongs_to :shopping_cart

  validate :validate_card, :on => :create
  
  
  private
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
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

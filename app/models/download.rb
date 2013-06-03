class Download < ActiveRecord::Base
  attr_accessible :link_expired
  attr_accessible :expiry_time
  attr_accessible :resource_id
  attr_accessible :shopping_cart_id
  attr_accessible :download_token
  attr_accessible :purchase_price_in_cents
  belongs_to :resource
  belongs_to :shopping_cart

end

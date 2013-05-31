class Download < ActiveRecord::Base
  attr_accessible :link_expired, :expiry_time, :resource_id, :shopping_cart_id, :download_token
  belongs_to :resource
  belongs_to :shopping_cart

end

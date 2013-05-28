class Download < ActiveRecord::Base
  attr_accessible :expiry, :link, :link_valid, :resource_id, :shopping_cart_id
  belongs_to :resource
  belongs_to :shopping_cart
end

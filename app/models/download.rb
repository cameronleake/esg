class Download < ActiveRecord::Base
  attr_accessible :expiry, :link, :link_verified, :resource_id, :user_id
  belongs_to :resource
  belongs_to :user
end

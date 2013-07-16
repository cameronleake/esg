class Download < ActiveRecord::Base
  attr_accessible :link_expired
  attr_accessible :expiry_time
  attr_accessible :resource_id
  attr_accessible :order_id
  attr_accessible :download_token
  attr_accessible :purchase_price_in_cents
  belongs_to :resource
  belongs_to :order                                  
  after_create :increase_resource_download_count
                                        
  
  def increase_resource_download_count
    @resource = self.resource
    @resource.number_of_downloads += 1
    @resource.save!
  end

end

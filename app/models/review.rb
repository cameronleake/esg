class Review < ActiveRecord::Base
  attr_accessible :body, :rating, :resource_id, :title, :user_id
  belongs_to :resource
  belongs_to :user
end

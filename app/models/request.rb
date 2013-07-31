class Request < ActiveRecord::Base
  attr_accessible :category_id
  attr_accessible :user_id    
  attr_accessible :title      
  attr_accessible :description
  validates_presence_of :category_id
  validates_presence_of :title
  validates_presence_of :description
  belongs_to :user
  belongs_to :category
                 
  
end

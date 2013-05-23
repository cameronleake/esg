class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :resources
  
    
  def resources_count(category)
    category.resources.count
  end
  
end

class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :resources
  
  
  def resources_count(category)
    category.resources.count
  end
  
  def resources_with_tag(category, tag)
    @resources = []
    category.resources.each do |resource|
      @resources << resource if resource.tag_list.include?(tag)
    end
    @resources
  end
  
end

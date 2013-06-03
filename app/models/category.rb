class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :resources
  
  
  def resources_count
    self.resources.count
  end
  
  def number_of_downloads
    @download_count = 0
    self.resources.each do |resource|
      @download_count += resource.downloads.count
    end
    return @download_count
  end
  
  def resources_with_tag(tag)
    @resources = []
    self.resources.each do |resource|
      @resources << resource if resource.tag_list.include?(tag)
    end
    return @resources
  end
  
end

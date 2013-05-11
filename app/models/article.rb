class Article < ActiveRecord::Base
  attr_accessible :body, :title, :featured_image, :tag_list
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable
end

class Article < ActiveRecord::Base
  attr_accessible :body, :title, :featured_image
  mount_uploader :featured_image, FeaturedImageUploader
end

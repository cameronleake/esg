class Article < ActiveRecord::Base
  attr_accessible :body, :title, :featured_image, :tag_list
  validates :title, :presence => true
  
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable

  has_many :blog_comments
  
  def comments_count(article)
    article.blog_comments.count
  end
  
end

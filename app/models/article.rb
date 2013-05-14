class Article < ActiveRecord::Base
  attr_accessible :body, :blurb, :title, :featured_image, :tag_list, :featured_article
  validates :title, :presence => true
  
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable

  has_many :blog_comments, :dependent => :destroy
  
  def comments_count(article)
    article.blog_comments.count
  end
  
end

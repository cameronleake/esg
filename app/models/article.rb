class Article < ActiveRecord::Base
  attr_accessible :body, :blurb, :title, :featured_image, :tag_list, :featured_article
  validates :title, :presence => true
  has_many :blog_comments, :dependent => :destroy
  
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable
  include PgSearch
  pg_search_scope :search, against: [:title, :body],
    using: {tsearch: {dictionary: "english"}}
  
  def comments_count(article)
    article.blog_comments.count
  end
  
  def self.text_search(query)
    search(query)
  end
  
end
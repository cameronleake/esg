class Article < ActiveRecord::Base
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable
  attr_accessible :body
  attr_accessible :blurb
  attr_accessible :title
  attr_accessible :featured_image
  attr_accessible :tag_list
  attr_accessible :featured_article
  validates :title, :presence => true
  has_many :blog_comments, :dependent => :destroy
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
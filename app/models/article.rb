class Article < ActiveRecord::Base
  mount_uploader :featured_image, FeaturedImageUploader
  acts_as_taggable
  attr_accessible :body
  attr_accessible :blurb
  attr_accessible :title
  attr_accessible :featured_image
  attr_accessible :tag_list
  attr_accessible :published
  attr_accessible :distributed_at              
  attr_accessible :author
  validates :title, :presence => true
  has_many :blog_comments, :dependent => :destroy
  has_many :article_images, :dependent => :destroy
  include PgSearch
  pg_search_scope :search, against: [:title, :body],
    using: {tsearch: {dictionary: "english", :prefix => true}} 
  after_create :set_author
  
  
  def comments_count(article)
    article.blog_comments.count
  end
  
  
  def self.text_search(query)
    search(query)
  end                     
  
  
  def set_author
    self.author = DEFAULT_ARTICLE_AUTHOR
    self.save!
  end
  
end
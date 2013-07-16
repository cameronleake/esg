class Resource < ActiveRecord::Base
  acts_as_taggable
  mount_uploader :image, ResourceImageUploader
  mount_uploader :file, ResourceFileUploader
  attr_accessible :category
  attr_accessible :description
  attr_accessible :file
  attr_accessible :image
  attr_accessible :name
  attr_accessible :price_in_cents
  attr_accessible :price_type
  attr_accessible :tag_list
  attr_accessible :user_id
  attr_accessible :category_id
  attr_accessible :featured_resource
  attr_accessible :number_of_downloads
  belongs_to :user
  belongs_to :category
  has_many :downloads, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_and_belongs_to_many :shopping_carts
  include PgSearch
  pg_search_scope :search, against: [:name, :description],
    using: { tsearch: {dictionary: "english", :prefix => true} }
    
    
  def number_of_reviews
    self.reviews.where(:spam => false).count
  end
  
  def self.text_search(query)
    search(query)
  end

end

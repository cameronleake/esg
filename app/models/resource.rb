class Resource < ActiveRecord::Base
  acts_as_taggable
  attr_accessible :category
  attr_accessible :description
  attr_accessible :file
  attr_accessible :image
  attr_accessible :name
  attr_accessible :number_of_downloads
  attr_accessible :price
  attr_accessible :price_type
  attr_accessible :tag_list
  attr_accessible :user_id
  attr_accessible :category_id
  belongs_to :user
  belongs_to :category
  has_many :downloads
  has_many :reviews

  def review_count(resource)
    resource.reviews.count
  end

end

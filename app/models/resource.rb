class Resource < ActiveRecord::Base
  attr_accessible :category, :description, :file, :image, :name, :number_of_downloads, :price, :type, :user_id
  belongs_to :user
  has_many :downloads
  has_many :reviews

  def review_count(resource)
    resource.reviews.count
  end

end

class ArticleImage < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader
  attr_accessible :image, :name
  belongs_to :article
  
end
class ArticleImage < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader
  attr_accessible :article_id, :image, :name
  belongs_to :article
end

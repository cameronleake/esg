class BlogComment < ActiveRecord::Base
  attr_accessible :body, :article_id, :user_id

  belongs_to :article
  belongs_to :user
end

class BlogComment < ActiveRecord::Base
  attr_accessible :body, :commenter, :article_id

  belongs_to :article
end

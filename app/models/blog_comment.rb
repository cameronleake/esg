class BlogComment < ActiveRecord::Base
  include Rakismet::Model
  attr_accessible :body, :article_id, :user_id
  rakismet_attrs  :author => proc { "#{user.first_name} #{user.last_name}" },
                  :author_email => proc { user.email },
                  :content => proc { :body }                          
  belongs_to :article
  belongs_to :user
  
end
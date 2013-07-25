class Review < ActiveRecord::Base
  include Rakismet::Model
  attr_accessible :body
  attr_accessible :rating
  attr_accessible :resource_id
  attr_accessible :title
  attr_accessible :user_id
  attr_accessible :spam
  rakismet_attrs  :author => proc { "#{user.first_name} #{user.last_name}" },
                  :author_email => proc { user.email },
                  :content => proc { :body }
  belongs_to :resource
  belongs_to :user
  

end

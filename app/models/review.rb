class Review < ActiveRecord::Base
  include Rakismet::Model
  rakismet_attrs  :author => proc { "#{user.first_name} #{user.last_name}" },
                  :author_email => proc { user.email },
                  :content => proc { :body }
  attr_accessible :body, :rating, :resource_id, :title, :user_id, :spam
  belongs_to :resource
  belongs_to :user
end

require 'spec_helper'

def post_comment(comment)
  visit article_path(@article)
  fill_in "blog_comment_body", :with => comment
  click_button "Post Comment"  
end
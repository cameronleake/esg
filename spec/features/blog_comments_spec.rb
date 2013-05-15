require 'spec_helper'
require 'helpers/blog_comments_helper_spec'
require 'helpers/login_helper_spec'

describe "BLOG COMMENTS:" do
  
  before(:all) do
    @user = FactoryGirl.create(:user)
    @article = FactoryGirl.create(:article)
  end
  
  after(:all) do
    @user.destroy
    @article.destroy
  end
  
  context "When User is Logged In:" do
    it "Should be able to make a comment on an article" do
      login_user(@user.email, @user.password)
      post_comment("Sample Comment")
      current_path.should eq(article_path(@article))
      page.should have_content("Sample text") && have_content("Comment submitted!")
      BlogComment.find(:last).should be_true
    end

    it "Should not be able to leave a blank comment" do
      login_user(@user.email, @user.password)
      post_comment("")
      current_path.should eq(article_path(@article))
      page.should have_content("Cannot submit a blank comment!")
      BlogComment.find(:last).should be_false
    end
  end
  
  context "When User is NOT logged in:" do
    it "Should not be able to leave a comment" do
      visit article_path(@article)
      page.should have_content("Sign Up") && have_content("Login")
      page.should_not have_content("blog_comment_body")
    end
  end
end
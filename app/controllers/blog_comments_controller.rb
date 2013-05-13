class BlogCommentsController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @blog_comment = @article.blog_comments.build(params[:blog_comment])
    @blog_comment.user_id = current_user.id
    @blog_comment.save!
    redirect_to article_path(@article), notice: "Comment submitted!"
  end
  
end

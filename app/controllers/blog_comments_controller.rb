class BlogCommentsController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @blog_comment = @article.blog_comments.build(params[:blog_comment])
    @blog_comment.user_id = current_user.id
    if @blog_comment.body?
      @blog_comment.save!
      redirect_to article_path(@article), notice: "Comment submitted!"
    else
      redirect_to article_path(@article), alert: "Cannot submit a blank comment!"
    end
  end
  
end

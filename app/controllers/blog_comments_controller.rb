class BlogCommentsController < ApplicationController
  
  def create
    @article = Article.find(params[:article_id])
    @blog_comment = @article.blog_comments.create(params[:blog_comment])
    redirect_to article_path(@article), notice: "Comment submitted!"
  end
  
end

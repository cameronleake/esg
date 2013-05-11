class ArticlesController < ApplicationController
  
  before_filter :authorize, only: [:edit, :update]
  
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).order("created_at DESC")
    else
      @articles = Article.find(:all, :order => "created_at DESC")
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to article_path(@article), notice: "Article has been updated."
    else
      render "edit"
    end
  end
  
end

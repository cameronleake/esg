class ArticlesController < ApplicationController
  
  before_filter :authorize_user_logged_in, only: [:edit, :update]
  
  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).order("created_at DESC").page(params[:page]).per(5)
    elsif params[:query].present?
      @articles = Article.text_search(params[:query]).page(params[:page]).per(5)
    else
      @articles = Article.order("created_at DESC").page(params[:page]).per(5)
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
  
  def featured_articles
    @articles = Article.order("created_at DESC")
    render :partial => 'featured_articles'
  end
  
  def mercury_update
    @article = Article.find(params[:id])
    @article.body = params[:content][:article_body][:value]
    @article.save!
    render :json => { :redirect_url => admin_article_path(@article) }
  end
    
end

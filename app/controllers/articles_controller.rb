class ArticlesController < ApplicationController
  before_filter :authorize_user_logged_in, only: [:edit, :update]
           
  
  def index     
    if params[:tag]
      @articles = Article.where(:published => true).tagged_with(params[:tag]).order("created_at DESC").page(params[:page]).per(NUMBER_ARTICLES_PER_PAGE)
      @tag_name = params[:tag]
    elsif params[:query].present?
      @articles = Article.where(:published => true).text_search(params[:query]).page(params[:page]).per(NUMBER_ARTICLES_PER_PAGE)
    else
      @articles = Article.where(:published => true).order("created_at DESC").page(params[:page]).per(NUMBER_ARTICLES_PER_PAGE)
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
  
  
  def mercury_update
    @article = Article.find(params[:id])
    @article.body = params[:content][:article_body][:value]
    @article.save!
    render :json => { :redirect_url => admin_article_path(@article) }
  end
    
end

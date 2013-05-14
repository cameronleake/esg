class HomeController < ApplicationController
  
  def index
    @featured_articles = Article.where(:featured_article => true).order("created_at DESC").page(params[:page]).per(2)
    @featured_article_count = @featured_articles.count
  end
  
end
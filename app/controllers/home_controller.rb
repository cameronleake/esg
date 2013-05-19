class HomeController < ApplicationController
  
  def index
    @featured_articles = Article.where(:published => true, :featured_article => true).order("created_at DESC").page(params[:page]).per(2)
  end
  
end
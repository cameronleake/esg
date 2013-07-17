class HomeController < ApplicationController
       
  
  def index
    @featured_articles = Article.where(:published => true, :featured_article => true).order("created_at DESC").limit(NUMBER_FEATURED_ARTICLES)
    @featured_resources = Resource.where(:featured_resource => true).order("created_at DESC").limit(NUMBER_FEATURED_RESOURCES) 
    @recent_resources = Resource.order("created_at DESC").limit(NUMBER_RECENT_RESOURCES)      
    @popular_resources = Resource.order("number_of_downloads DESC").limit(NUMBER_POPULAR_RESOURCES) 
    @recent_articles = Article.order("created_at DESC").limit(NUMBER_RECENT_ARTICLES)         
  end                                      
                       
end
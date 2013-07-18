class HomeController < ApplicationController
       
  
  def index
    @recent_resources = Resource.order("created_at DESC").limit(NUMBER_RECENT_RESOURCES)      
    @popular_resources = Resource.order("number_of_downloads DESC").limit(NUMBER_POPULAR_RESOURCES) 
    @recent_articles = Article.order("created_at DESC").limit(NUMBER_RECENT_ARTICLES)         
  end                                      
                       
end
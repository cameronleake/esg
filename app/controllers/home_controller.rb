class HomeController < ApplicationController
       
  
  def index
    @newest_resources = Resource.order("created_at DESC").limit(NUMBER_NEWEST_RESOURCES)      
    @newest_articles = Article.order("created_at DESC").limit(NUMBER_NEWEST_ARTICLES)         
    @popular_resources = Resource.order("number_of_downloads DESC").limit(NUMBER_POPULAR_RESOURCES) 
  end                                      
                       
end
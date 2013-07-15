class HomeController < ApplicationController
       
  
  def index
    @featured_articles = Article.where(:published => true, :featured_article => true).order("created_at DESC").limit(NUMBER_FEATURED_ARTICLES)
    @featured_resources = Resource.where(:featured_resource => true).order("created_at DESC").limit(NUMBER_FEATURED_RESOURCES)
  end                                      
                       
end
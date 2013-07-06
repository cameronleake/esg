class HomeController < ApplicationController
  
  def index
    @header_type = "Index"
    @featured_articles = Article.where(:published => true, :featured_article => true).order("created_at DESC").limit(NUMBER_FEATURED_ARTICLES)
    @featured_resources = Resource.where(:featured_resource => true).order("created_at DESC").limit(NUMBER_FEATURED_RESOURCES)
  end                                      
                       
  
  def ebook
    @header_type = "EBook"
  end
           
  
  def faq
    @header_type = "FAQ"
  end
  
end
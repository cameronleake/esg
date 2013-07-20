class ResourcesController < ApplicationController
         
  
  def show
    @resource = Resource.find(params[:id])
    @category = Category.find(@resource.category_id)
    if params[:tag]
      @tag_name = params[:tag]
    end  
    @resources_in_category = Resource.order("number_of_downloads DESC").where(:category_id => @category.id)
    @related_resources = []
    @resources_in_category.each do |resource|
      if resource != @resource
        @related_resources << resource
      end                      
      if @related_resources.count >= NUMBER_RELATED_RESOURCES
        break
      end
    end
  end
  
  
  def search
    @search_term = params[:query]
    @resources = Resource.text_search(params[:query])
  end

end
class ResourcesController < ApplicationController
  
  def show
    @resource = Resource.find(params[:id])
    @category = Category.find(@resource.category_id)
    if params[:tag]
      @tag_name = params[:tag]
    end
  end
  
  
  def search
    @search_term = params[:query]
    @resources = Resource.text_search(params[:query])
  end

end
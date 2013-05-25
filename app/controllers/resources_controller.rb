class ResourcesController < ApplicationController
  
  def show
    @resource = Resource.find(params[:id])
  end
  
  def show_filtered
    if params[:tag]
      @tag_name = params[:tag]
    end
    @resource = Resource.find(params[:id])
  end

end

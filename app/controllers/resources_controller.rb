class ResourcesController < ApplicationController

  def index
    @resources = Resource.find(:all)
    @categories = Category.find(:all)
  end

end

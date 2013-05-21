class ResourcesController < ApplicationController

  def index
    @resources = Resource.find(:all)
  end

end

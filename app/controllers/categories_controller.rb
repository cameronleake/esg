class CategoriesController < ApplicationController

  def index
    @categories = Category.find(:all)
  end

  def show
    @resources = Resource.where(:category_id => params[:id])
    @category = Category.find(params[:id])
  end

end
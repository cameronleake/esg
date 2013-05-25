class CategoriesController < ApplicationController

  def index
    @categories = categories_with_resources
  end
  
  def index_filtered
    if params[:tag]
      @tag_name = params[:tag]
    end
    @filtered_categories = categories_with_resources_and_tag(@tag_name)
  end

  def show
    @category = Category.find(params[:id])
    @resources = Resource.order("name ASC").where(:category_id => params[:id])
  end
  
  def show_filtered
    if params[:tag]
      @tag_name = params[:tag]
    end
    @category = Category.find(params[:id])
    @filtered_resources = resources_with_tag(@category, @tag_name)
  end
  
  
  private
  
  def categories_with_resources
    @categories = []
    Category.order("name ASC").find(:all).each do |category|
      @categories << category if category.resources.count > 0
    end
    @categories
  end

  def categories_with_resources_and_tag(tag)
    @categories = []
    Category.order("name ASC").find(:all).each do |category|
      category.resources.each do |resource|
        if resource.tag_list.include?(tag)
          @categories << category
          break
        end
      end
    end
    @categories
  end

  def resources_with_tag(category, tag)
    @resources = []
    category.resources.order("name ASC").find(:all).each do |resource|
      if resource.tag_list.include?(tag)
        @resources << resource
      end
    end
    @resources
  end

end
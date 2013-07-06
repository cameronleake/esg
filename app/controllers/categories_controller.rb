class CategoriesController < ApplicationController


  def index
    @header_type = "Resource Centre"
    @categories = categories_with_resources
    if params[:tag]
      @tag_name = params[:tag]
      @filtered_categories = categories_with_resources_and_tag(@tag_name)
    end
  end
                                       

  def show 
    @header_type = "Resource Centre"       
    @category = Category.find(params[:id])
    @resources = Resource.order("name ASC").where(:category_id => params[:id]).page(params[:page]).per(5)
    if params[:tag]
      @tag_name = params[:tag]
      @filtered_resources = resources_with_tag(@category, @tag_name)      # <TODO> Add Pagination
    end
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
    @categories = category.resources.order("name ASC").find(:all).each do |resource|
      if resource.tag_list.include?(tag)
        @resources << resource
      end
    end
    @resources
  end

end
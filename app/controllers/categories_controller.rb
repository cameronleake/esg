class CategoriesController < ApplicationController


  def index
    @resources = Resource.order("created_at DESC").page(params[:page]).per(NUMBER_RESOURCES_PER_PAGE)
    @categories = categories_with_resources
    if params[:tag]
      @tag_name = params[:tag]
      @filtered_categories = categories_with_resources_and_tag(@tag_name)
      @filtered_resources = resources_with_tag(@tag_name)
      @filtered_resources = Kaminari.paginate_array(@filtered_resources).page(params[:page]).per(NUMBER_RESOURCES_PER_PAGE)            
    end 
  end
                                       

  def show    
    @category = Category.find(params[:id])
    @resources = Resource.order("created_at DESC").where(:category_id => params[:id]).page(params[:page]).per(NUMBER_RESOURCES_PER_PAGE)
    if params[:tag]
      @tag_name = params[:tag]
      @filtered_resources = resources_in_category_with_tag(@category, @tag_name) 
      @filtered_resources = Kaminari.paginate_array(@filtered_resources).page(params[:page]).per(NUMBER_RESOURCES_PER_PAGE)      
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
   

  def resources_with_tag(tag)
    @resources = []
    Resource.order("created_at DESC").all.each do |resource|
      if resource.tag_list.include?(tag)
        @resources << resource
      end
    end
    @resources
  end
     

  def resources_in_category_with_tag(category, tag)
    @resources = []
    category.resources.order("created_at DESC").each do |resource|
      if resource.tag_list.include?(tag)
        @resources << resource
      end
    end
    @resources
  end

end
module ResourcesHelper
  
  def display_category_tag_links(current_resource)
    raw current_resource.tag_list.map { |t| link_to t, category_tag_path(t) }.join(', ')
  end
  
  def already_in_cart(resource)
    @resource = resource
    authorize_shopping_cart_exists
    @cart = current_shopping_cart
    if @cart.resources.include?(@resource)
      return true
    else
      return false
    end
  end
  
end
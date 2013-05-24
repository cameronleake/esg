module ResourcesHelper
  
  def display_category_tag_links(current_resource)
    raw current_resource.tag_list.map { |t| link_to t, category_tag_path(t) }.join(', ')
  end
  
end
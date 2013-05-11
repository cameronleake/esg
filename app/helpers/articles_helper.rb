module ArticlesHelper
  
  def display_tag_links(current_article)
    raw current_article.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
  end
  
end

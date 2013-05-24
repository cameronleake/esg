module ArticlesHelper
  
  def display_article_tag_links(current_article)
    raw current_article.tag_list.map { |t| link_to t, article_tag_path(t) }.join(', ')
  end
  
  def display_avatar_image(user)
	  if user.avatar?
			image_tag user.avatar_url(:avatar).to_s
    else
			image_tag "/assets/Default_Avatar_Icon.jpg"
		end
  end
  
end

ActiveAdmin.register Article do
  menu :priority => 3
  menu :parent => "ESG Blog"
  scope :all, :default => true
  scope :featured_articles do |articles|
    articles.where(:featured_article => true)
  end
  
  # Configuration for Sidebar Filters
  filter :title
  filter :blurb
  filter :body
  filter :featured_article, :as => :select
  filter :created_at   
  filter :updated_at
  filter :tag_list
  
  
  # Configuration for Articles Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
    selectable_column
    column :title
    column :created_at
    default_actions
  end
  
  
  # Configuration for Articles Show Page
  show do |article|
    attributes_table do
      row :title
      row :blurb
      row :body do |article|
        article.body.html_safe
      end
      row :image do
        image_tag(article.featured_image.url(:thumb))
      end
      row :tag_list
      row :featured_article do |user|
        article.featured_article.yesno
      end
      row :created_at
      row :updated_at
      row :body do |article|
        link_to "LAUNCH HTML EDITOR", "/editor#{article_path(article)}", id: "edit_link"
      end
    end
    active_admin_comments
  end
  
  
  # Configuration for Articles Edit Page
  form do |f|                         
    f.inputs "New Article" do       
      f.input :title
      f.input :blurb, as: :text, :input_html => { :rows => 6, :maxlength => 255 }
      f.input :body, as: :text
      f.input :featured_image, :as => :file, :input_html => { :accept => "image/*" }
      f.input :tag_list, :label => "Tags (separated by commas)"
      f.input :featured_article, :as => :select
    end                               
    f.actions                         
  end

end
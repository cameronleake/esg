ActiveAdmin.register ArticleImage do
  menu :parent => "ESG Blog"
  scope :all, :default => true


  # Configuration for Sidebar Filters
  filter :article, :as => :select
  filter :name
  filter :created_at   
  filter :updated_at
  
  
  # Configuration for Article Images Index Pages
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
    selectable_column
    column :article
    column :name
    column :created_at
    default_actions
  end
  
  index :as => :grid, :default => true do |article_image|
    link_to(image_tag(article_image.image.url(:thumb)), admin_article_image_path(article_image))
  end
  
  
  # Configuration for Article Images Show Page
  show do |article_image|
    attributes_table do
      row :image do
        image_tag(article_image.image.url(:medium))
      end
      row :name
      row :article_id
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Article Images Edit Page
  form do |f|                         
    f.inputs "New Article" do       
      f.input :image, :as => :file, :input_html => { :accept => "image/*" }
      f.input :name
      f.input :article, :as => :select
    end                               
    f.actions                         
  end
  
end

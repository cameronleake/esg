ActiveAdmin.register ArticleImage do
  menu :parent => "ESG BLOG", :label => "Images", :priority => 3
  scope :all, :default => true


  # Configuration for Sidebar Filters
  config.clear_sidebar_sections!
  
  
  # Configuration for Article Images Index Pages
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index :default => true do
    selectable_column
    column :image do |article_image|
      link_to image_tag(article_image.image.url(:small)), admin_article_image_path(article_image)
    end
    column :created_at
    default_actions
  end
  
  index :as => :grid do |article_image|
    link_to(image_tag(article_image.image.url(:small)), admin_article_image_path(article_image))
  end
  
  
  # Configuration for Article Images Show Page
  show do |article_image|
    attributes_table do
      row "IMAGE (SMALL)" do
        image_tag(article_image.image.url(:small))
      end
      row " " do
        article_image.image.url(:small)
      end
      row "IMAGE - (MEDIUM)" do
        image_tag(article_image.image.url(:medium))
      end
      row " " do
        article_image.image.url(:medium)
      end
      row "IMAGE - (LARGE)" do
        image_tag(article_image.image.url(:large))
      end
      row " " do
        article_image.image.url(:large)
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Article Images Edit Page
  form do |f|                         
    f.inputs "New Article Image" do
      f.input :image, :as => :file, :input_html => { :accept => "image/*" }
    end                               
    f.actions                         
  end
  
end

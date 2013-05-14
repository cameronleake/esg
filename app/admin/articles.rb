ActiveAdmin.register Article do
  menu :priority => 3

  filter :title
  filter :blurb
  filter :body
  filter :featured_article, :as => :select
  filter :created_at   
  filter :updated_at
  filter :tag_list
  
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
    selectable_column
    column :title
    column :tag_list
    column :featured_article, :sortable => :featured_article do |article|
      div :class => "admin-center-column" do 
        article.featured_article.yesno
      end
    end    
    column :created_at
    column :updated_at
    default_actions
  end
  
  form do |f|                         
    f.inputs "New Article" do       
      f.input :title
      f.input :blurb, as: :text
      f.input :body, as: :text
      f.input :tag_list, :label => "Tags (separated by commas)"
      f.input :featured_image, :as => :file
      f.input :featured_article, :as => :select
    end                               
    f.actions                         
  end

end
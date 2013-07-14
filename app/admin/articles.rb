ActiveAdmin.register Article do
  menu :parent => "ESG BLOG", :priority => 1   
  config.filters = false  
  scope :all, :default => true
  scope :featured_articles do |articles|
    articles.where(:featured_article => true)
  end
  scope :draft_articles do |articles|
    articles.where(:published => false)
  end
  scope :published_articles do |articles|
    articles.where(:published => true)
  end
  scope :not_yet_distributed do |articles|
    articles.where(:distributed_at => nil)
  end
  
  
  # Configuration for Articles Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
    selectable_column
    column :title
    column :published, :sortable => :published do |article|
       div :class => "admin-center-column" do 
          article.published.published_status
       end
    end
    column :featured_article, :sortable => :featured_article do |article|
       div :class => "admin-center-column" do 
          article.featured_article.featured_article
       end
    end
    column :distributed_at
    column :created_at
    default_actions
  end
  
  
  # Configuration for Articles Show Page
  show do |article|
    attributes_table do
      row :title
      row :blurb
      row " " do |article|
        link_to "LAUNCH HTML EDITOR", "/editor#{article_path(article)}", id: "edit_link"
      end
      row :body do |article|
        article.body.html_safe
      end
      row "Featured Image" do
        image_tag(article.featured_image.url(:thumb))
      end
      row :tag_list
      row "PUBLISHED TO BLOG?" do |article|
        article.published.published_status
      end
      row "FEATURED ARTICLE?" do |article|
        article.featured_article.featured_article
      end
      row :distributed_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Articles Edit Page
  form do |f|                         
    f.inputs "New Article" do       
      f.input :title
      f.input :blurb, as: :text, :input_html => { :rows => 6, :maxlength => 255 }   
      f.input :body, as: :text, :input_html => { :rows => 12 }   
      f.input :featured_image, :as => :file, :input_html => { :accept => "image/*" }
      f.input :tag_list  #  <TODO>: Fix Tag List as Checkboxes, ie. (, as: :check_boxes, :collection => Tag.order("name ASC").all)
      f.input :featured_article, :as => :select, :include_blank => false, :collection => [["Featured", true], ["No", false]]
      f.input :published, :as => :select, :include_blank => false, :collection => [["Published", true], ["Draft", false]]
    end                               
    f.actions                         
  end
  
  
  # Configuration for Articles Batch Actions
  ActiveAdmin.register Article do
    batch_action :publish, :priority => 1 do |selection|
      Article.find(selection).each do |article|
        article.published = true
        article.save
      end
      redirect_to admin_articles_path
    end
    
    batch_action :draft, :priority => 2 do |selection|
      Article.find(selection).each do |article|
        article.published = false
        article.save
      end
      redirect_to admin_articles_path
    end
    
    batch_action :feature, :priority => 2 do |selection|
      Article.find(selection).each do |article|
        article.featured_article = true
        article.save
      end
      redirect_to admin_articles_path
    end
    
    batch_action "Un-Feature", :priority => 2 do |selection|
      Article.find(selection).each do |article|
        article.featured_article = false
        article.save
      end
      redirect_to admin_articles_path
    end
  end

end
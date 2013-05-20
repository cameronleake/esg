ActiveAdmin.register BlogComment do
  menu :parent => "ESG BLOG", :label => "Comments", :priority => 2
  scope :all
  scope :spam do |blog_comment|
    blog_comment.where(:spam => true)
  end
  scope :not_spam do |blog_comment|
    blog_comment.where(:spam => false)
  end
  
  
  # Configuration for Sidebar Filters
  filter :comment
  filter :article
  filter :user
  filter :spam, :as => :select
  filter :created_at


  # Configuration for Blog Comments Index Page  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column                 
    column :article
    column :user
    column :created_at               
    default_actions                   
  end                                                      
  
  
  # Configuration for Blog Comments Show Page
  show do |blog_comment|
    attributes_table do
      row :spam do |blog_comment|
        blog_comment.spam.yesno
      end
      row :article
      row :user
      row :body
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end


  # Configuration for Blog Comments Edit Page
  form do |f|                         
   f.inputs "New Blog Comment" do       
     f.input :spam, :as => :select, :include_blank => false
     f.input :article, :as => :select, :include_blank => false
     f.input :user, :as => :select, :include_blank => false
     f.input :body
   end                               
   f.actions                         
  end
end

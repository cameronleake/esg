ActiveAdmin.register BlogComment do
  menu :priority => 3
  menu :label => "Blog Comments"
  menu :parent => "ESG Blog"
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
  filter :user, :as => :select
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
      row :article
      row :user
      row :user do |blog_comment|
        link_to blog_comment.user.get_user_email, admin_user_path(blog_comment.user)
      end
      row :body
      row :spam do |blog_comment|
        blog_comment.spam.yesno
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end


  # Configuration for Blog Comments Edit Page
  form do |f|                         
   f.inputs "New Blog Comment" do       
     f.input :article, :as => :select
     f.input :user, :as => :select
     f.input :body
     f.input :spam, :as => :select
   end                               
   f.actions                         
  end
end

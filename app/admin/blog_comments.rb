ActiveAdmin.register BlogComment do
  menu :priority => 4
  menu :label => "Blog Comments"
  menu :parent => "ESG Blog"
  scope :spam do |blog_comment|
    blog_comment.where(:spam => true)
  end
  scope :all
  scope :not_spam do |blog_comment|
    blog_comment.where(:spam => false)
  end
  
  
  # Configuration for Sidebar Filters
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
    column :spam, :sortable => :spam do |blog_comment|
       div :class => "admin-center-column" do 
          blog_comment.spam.yesno
       end
    end
    column :created_at               
    default_actions                   
  end                                                      
  
end

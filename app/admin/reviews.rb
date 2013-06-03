ActiveAdmin.register Review do
  menu :parent => "RESOURCES", :priority => 4
  scope :all, :default => true  
  scope :spam do |review|
    review.where(:spam => true)
  end


  # Configuration for Sidebar Filters
  filter :resource
  filter :user
  filter :rating, as: :select, :include_blank => false, :collection => RESOURCE_RATINGS
  filter :spam
  filter :body


  # Configuration for Reviews Index Page
  config.sort_order = "creatd_at DESC"
  config.per_page = 15
  
  index do
   selectable_column
   column :resource
   column :user
   column :rating, :sortable => :rating do |review|
     div :class => "admin-center-column" do 
       review.rating
     end
   end
   column :spam, :sortable => :spam do |review|
     div :class => "admin-center-column" do 
       review.spam.yesno
     end
   end
   default_actions
  end
  
  
  # Configuration for Reviews Show Page
  show do |resource|
    attributes_table do
      row :resource
      row :user
      row :rating
      row :title
      row :body
      row :spam do |review|
        review.spam.yesno
      end
      row :created_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Reviews Edit Page
  form do |f|                         
   f.inputs "New Review" do       
     f.input :resource, :include_blank => false
     f.input :user, :include_blank => false
     f.input :rating, as: :select, :include_blank => false, :collection => RESOURCE_RATINGS
     f.input :title
     f.input :body
     f.input :spam, as: :select, :include_blank => false
   end                               
   f.actions                         
  end
  
end

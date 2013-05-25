ActiveAdmin.register Resource do
  menu :parent => "RESOURCES", :priority => 2
  scope :all, :default => true
  scope :featured_resource do |resource|
    resource.where(:featured_resource => true)
  end
  scope :free do |resource|
    resource.where(:price_type => "Free")
  end
  scope :paid do |resource|
    resource.where(:price_type => "Paid")
  end


  # Configuration for Sidebar Filters
  filter :user
  filter :category
  filter :featured_resource, :as => :select
  filter :name
  filter :price_type, :as => :select, :collection => ["Paid", "Free"]
  filter :price


  # Configuration for Resources Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column :category
   column :name
   column :price, :sortable => :price do |resource|
     div :class => "admin-center-column" do 
       if resource.price == 0
         "Free"
       else
         "$#{resource.price}"
       end
     end
   end
   column :featured_resource, :sortable => :featured_resource do |resource|
     div :class => "admin-center-column" do 
       resource.featured_resource.featured_article
     end
   end
   default_actions
  end
  
  
  # Configuration for Resources Show Page
  show do |resource|
    attributes_table do
      row :user
      row :category
      row :name
      row :description
      row :price_type
      row :price
      row :number_of_downloads
      row :file
      row :image
      row :tag_list
      row :featured_resource
      row :created_at
      row "Preview Image" do
        image_tag(resource.image.url(:preview)) if resource.image?
      end
    end
    active_admin_comments
  end
  
  
  # Configuration for Resources Edit Page
  form do |f|                         
   f.inputs "New User" do       
     f.input :user, :as => :select, :include_blank => false
     f.input :category, :as => :select, :include_blank => false
     f.input :name
     f.input :description
     f.input :price_type, :as => :select, :include_blank => false, :collection => ["Paid", "Free"]
     f.input :price
     f.input :tag_list  #  <TODO>: Fix Tag List as Checkboxes, ie. (, as: :check_boxes, :collection => Tag.order("name ASC").all)
     f.input :file, :as => :file
     f.input :image, :as => :file, :input_html => { :accept => "image/*" }
     f.input :featured_resource, :as => :select, :include_blank => false
   end                               
   f.actions                         
  end
  
  
  # Configuration for Resources Batch Actions
  ActiveAdmin.register Resource do
    batch_action :feature, :priority => 1 do |selection|
      Resource.find(selection).each do |resource|
        resource.featured_resource = true
        resource.save
      end
      redirect_to admin_resources_path
    end
    
    batch_action "Un-Feature", :priority => 1 do |selection|
      Resource.find(selection).each do |resource|
        resource.featured_resource = false
        resource.save
      end
      redirect_to admin_resources_path
    end
  end
  
end

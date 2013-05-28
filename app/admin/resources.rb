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
  filter :price_type, :as => :select, :collection => PRICE_TYPES
  filter :price_in_cents


  # Configuration for Resources Index Page
  config.sort_order = "category ASC"
  config.per_page = 15
  
  index do
   selectable_column
   column :category
   column :name
   column "Price", :sortable => :price_in_cents do |resource|
     div :class => "admin-center-column" do 
       if resource.price_in_cents == 0
         "Free"
       else
         "$" + number_with_precision(resource.price_in_cents.to_f/100, :precision => 2)
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
      row :tag_list
      row :price_type
      row "Price" do
         "$" + number_with_precision(resource.price_in_cents.to_f/100, :precision => 2)
      end
      row :number_of_downloads
      row :featured_resource do
        resource.featured_resource.yesno
      end
      row :file do
        link_to "View File", resource.file_url if resource.file?
      end
      row "Preview Image" do
        image_tag(resource.image.url(:preview)) if resource.image?
      end
      row :created_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Resources Edit Page
  form do |f|                         
   f.inputs "New User" do       
     f.input :user
     f.input :category, :as => :select, :include_blank => false
     f.input :name
     f.input :description
     f.input :price_type, :as => :select, :include_blank => false, :collection => PRICE_TYPES
     f.input :price_in_cents
     f.input :tag_list  #  <TODO>: Fix Tag List as Checkboxes, ie. (, as: :check_boxes, :collection => Tag.order("name ASC").all)
     f.input :file, :as => :file, :input_html => { :accept => "application/pdf" }, hint: resource.file_url
     f.input :image, :as => :file, :input_html => { :accept => "image/*" }, hint: image_tag(resource.image.url(:thumb))
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

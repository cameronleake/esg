ActiveAdmin.register Resource do
  menu :parent => "RESOURCES", :priority => 2
  scope :all, :default => true
  @categories = []
  Category.find(:all).each do |category|
    @categories << category
  end
  @categories.each do |category|
    scope "#{category.name}" do |resource|
      resource.where(:category_id => category.id)
    end
  end


  # Configuration for Sidebar Filters
  filter :user
  filter :category
  filter :name
  filter :price_type, :as => :select, :collection => ["Paid", "Free"]
  filter :price


  # Configuration for Resources Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column :user
   column :category
   column :name
   column :price_type
   column :price, :sortable => :price do |resource|
     div :class => "admin-center-column" do 
       if resource.price == 0
         "Free"
       else
         "$#{resource.price}"
       end
     end
   end
   column "Downloads", :sortable => :number_of_downloads do |resource|
     div :class => "admin-center-column" do 
       resource.number_of_downloads
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
      row :created_at
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
     f.input :image, :as => :file
   end                               
   f.actions                         
  end
  
end

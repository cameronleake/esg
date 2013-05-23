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
  filter :price


  # Configuration for Resources Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column :user
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
      row :type
      row :price
      row :number_of_downloads
      row :file
      row :image
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
     f.input :type
     f.input :price
     f.input :file, :as => :file
     f.input :image, :as => :file
   end                               
   f.actions                         
  end
  
end

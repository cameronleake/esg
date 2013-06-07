ActiveAdmin.register Download do
  menu :parent => "RESOURCES", :priority => 4
  actions :index, :show, :destroy
  scope :all, :default => true  
  

  # Configuration for Sidebar Filters
  filter :resource
  filter :shopping_cart
  filter :link_expired, :as => :select
  filter :expiry_time
  
  
  # Configuration for Downloads Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column "Order No." do |download|
     div :class => "admin-center-column" do 
       link_to "##{download.shopping_cart.order_number}", admin_shopping_cart_path(download.shopping_cart_id)
     end
   end
   column :resource
   column "Downloads" do |download|
     div :class => "admin-center-column" do 
       download.times_accessed
     end
   end
   column :link_expired, :sortable => :link_expired do |download|
     div :class => "admin-center-column" do 
       download.link_expired.yesno
     end
   end
   column :expiry_time
   default_actions
  end
  
  
  # Configuration for Downloads Show Page
  show do |download|
    attributes_table do
      row :shopping_cart
      row :resource
      row :times_accessed   
      row "Purchase Price" do
        "$" + number_with_precision(download.purchase_price_in_cents.to_f/100, :precision => 2)
      end
      row :link_expired do
        download.link_expired.yesno
      end
      row :expiry_time
      row :download_token
    end
    active_admin_comments
  end
    
end

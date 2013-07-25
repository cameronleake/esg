ActiveAdmin.register Download do
  menu :parent => "RESOURCES", :priority => 4
  actions :index, :show, :destroy
  scope :all, :default => true  
  scope "Active" do |download|
    download.where("expiry_time >= ?", Time.now.yesterday)
  end
  scope "Expired" do |download|
    download.where("expiry_time < ?", Time.now.yesterday)
  end                                         
                  
  
  # Configuration for Sidebar Filters     
  filter :resource      
  filter :order
  filter :times_accessed
  filter :expiry_time   
  
  
  # Configuration for Downloads Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column "Order No." do |download|
     div :class => "admin-center-column" do 
       link_to "##{download.order.order_number}", admin_order_path(download.order.id)
     end
   end
   column :resource
   column "Downloads" do |download|
     div :class => "admin-center-column" do 
       download.times_accessed
     end
   end
   column "Link Expired" do |download|
     div :class => "admin-center-column" do 
       if download.expiry_time >= Time.now.yesterday
         "Active"
       elsif download.expiry_time < Time.now.yesterday
         "Expired"
       end
     end
   end
   column :expiry_time
   default_actions
  end
  
  
  # Configuration for Downloads Show Page
  show do |download|
    attributes_table do
      row :order do |download|
        link_to "##{download.order.order_number}", admin_order_path(download.order.id)
      end
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

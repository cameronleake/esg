ActiveAdmin.register ShoppingCart do
  
  menu :parent => "RESOURCES", :priority => 3
  scope :all, :default => true
  scope :payment_verified do |cart|
    cart.where(:payment_verified => true)
  end
  scope :payment_not_verified do |cart|
    cart.where(:payment_verified => false)
  end
  scope :email_sent do |cart|
    cart.where(:email_sent => true)
  end
  scope :email_not_sent do |cart|
    cart.where(:email_sent => false)
  end
  

  # Configuration for Sidebar Filters
  filter :user
  filter :payment_verified, :as => :select
  filter :email_sent, :as => :select


  # Configuration for Shopping Carts Index Page
  config.sort_order = "category ASC"
  config.per_page = 15
  
  index do
   selectable_column
   column :user
   column :payment_verified, :sortable => :payment_verified do |cart|
     div :class => "admin-center-column" do 
       cart.payment_verified.yesno
     end
   end
   column :email_sent, :sortable => :email_sent do |cart|
     div :class => "admin-center-column" do 
       cart.email_sent.yesno
     end
   end
   column :created_at
   default_actions
  end
  
  
  # Configuration for Shopping Carts Show Page
  show do |cart|
    attributes_table do
      row :user
      row "Cart Contents" do
        table_for(cart.resources, :sortable => true) do
          column :name
          column "Price", :sortable => :price_in_cents do |cart|
            "$" + number_with_precision(cart.price_in_cents.to_f/100, :precision => 2)
          end
        end
      end
      row "Total Price" do
        @resource_prices = []
        cart.resources.each do |resource|
          @resource_prices << resource.price_in_cents
        end
        @total_price = @resource_prices.reduce(:+)
        "$" + number_with_precision(@total_price.to_f/100, :precision => 2)
      end
      row :payment_verified do
        cart.payment_verified.yesno
      end
      row :email_sent do
        cart.email_sent.yesno
      end
      row :created_at
    end
    active_admin_comments
  end
  
  
  # # Configuration for Resources Edit Page
  # form do |f|                         
  #  f.inputs "New User" do       
  #    f.input :user
  #    f.input :category, :as => :select, :include_blank => false
  #    f.input :name
  #    f.input :description
  #    f.input :price_type, :as => :select, :include_blank => false, :collection => ["Paid", "Free"]
  #    f.input :price_in_cents
  #    f.input :tag_list  #  <TODO>: Fix Tag List as Checkboxes, ie. (, as: :check_boxes, :collection => Tag.order("name ASC").all)
  #    f.input :file, :as => :file, :input_html => { :accept => "application/pdf" }, hint: resource.file_url
  #    f.input :image, :as => :file, :input_html => { :accept => "image/*" }, hint: image_tag(resource.image.url(:thumb))
  #    f.input :featured_resource, :as => :select, :include_blank => false
  #  end                               
  #  f.actions                         
  # end
  # 
  # 
  # # Configuration for Resources Batch Actions
  # ActiveAdmin.register Resource do
  #   batch_action :feature, :priority => 1 do |selection|
  #     Resource.find(selection).each do |resource|
  #       resource.featured_resource = true
  #       resource.save
  #     end
  #     redirect_to admin_resources_path
  #   end
  # 
  #   batch_action "Un-Feature", :priority => 1 do |selection|
  #     Resource.find(selection).each do |resource|
  #       resource.featured_resource = false
  #       resource.save
  #     end
  #     redirect_to admin_resources_path
  #   end
  # end
  
end

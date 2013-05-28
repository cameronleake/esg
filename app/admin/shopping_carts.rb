ActiveAdmin.register ShoppingCart do
  
  menu :parent => "RESOURCES", :priority => 3
  scope :all, :default => true
  scope :open_orders do |cart|
    cart.where(:status => "OPEN")
  end
  scope :closed_orders do |cart|
    cart.where(:status => "CLOSE")
  end
  

  # Configuration for Sidebar Filters
  filter :user
  filter :payment_verified, :as => :select
  filter :email_sent, :as => :select
  filter :status, :as => :select, :include_blank => false, :collection => SHOPPING_CART_STATUSES


  # Configuration for Shopping Carts Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column :order_number
   column :status
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
      row :order_number
      row :status
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
  
  
  # Configuration for Shopping Carts Edit Page
  form do |f|                         
   f.inputs "New Shopping Cart" do       
     f.input :order_number
     f.input :status, :as => :select, :include_blank => false, :collection => SHOPPING_CART_STATUSES
     f.input :user
     f.input :payment_verified, :as => :select, :include_blank => false
     f.input :email_sent, :as => :select, :include_blank => false
   end                               
   f.actions                         
  end
  
end

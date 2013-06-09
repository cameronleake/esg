ActiveAdmin.register ShoppingCart do
  menu :parent => "ORDERS", :priority => 1
  scope :all, :default => true
  scope "Open" do |cart|
    cart.where(:status => "Open")
  end
  scope "Closed" do |cart|
    cart.where(:status => "Closed")
  end
  scope "Abandoned" do |cart|
    cart.where(:status => "Abandoned")
  end
  

  # Configuration for Sidebar Filters
  filter :user
  filter :status, :as => :select, :include_blank => false, :collection => SHOPPING_CART_STATUSES


  # Configuration for Shopping Carts Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
   selectable_column
   column :user    
   column "Cart Number" do |cart|
     div :class => "admin-center-column" do  
       "Cart ##{cart.id}"
     end
   end
   column "Cart Status" do |cart|
     div :class => "admin-center-column" do     
       cart.status
     end
   end 
   column "Order Number" do |cart|
     div :class => "admin-center-column" do 
       link_to "##{cart.order.order_number}", admin_order_path(cart.order_id)  
     end
   end
   # column "Order Status" do |cart|                # <TODO>
   #   div :class => "admin-center-column" do       
   #     cart.order.status
   #   end
   # end 
   # column "Order Number" do |cart|
   #   div :class => "admin-center-column" do  
   #     link_to "##{cart.order.order_number}", admin_order_path(cart.order.id)
   #   end
   # end     
   default_actions
  end
  
  
  # Configuration for Shopping Carts Show Page
  show do |cart|
    attributes_table do
      row :user
      row "Cart Id" do |cart|
        "Cart ##{cart.id}"
      end
      row :status  
      row "Total Price" do
        @resource_prices = []
        cart.resources.each do |resource|
          @resource_prices << resource.price_in_cents
        end
        @total_price = @resource_prices.reduce(:+)
        "$" + number_with_precision(@total_price.to_f/100, :precision => 2)
      end
      row :created_at  
      row :purchased_at  
      row "Cart Contents" do
        table_for(cart.resources) do
          column :name do |resource|
            link_to resource.name, admin_resource_path(resource)
          end
          column "Price", :sortable => :price_in_cents do |resource|
            "$" + number_with_precision(resource.price_in_cents.to_f/100, :precision => 2)
          end  
        end
      end
      row "Order Number" do |cart|
        link_to "##{cart.order.order_number}", admin_order_path(cart.order.id)
      end
    end
    active_admin_comments
  end
  
  
  # Configuration for Shopping Carts Edit Page
  form do |f|                         
   f.inputs "New Shopping Cart" do       
     f.input :status, :as => :select, :include_blank => false, :collection => SHOPPING_CART_STATUSES
     f.input :user
   end                               
   f.actions                         
  end
  
end

ActiveAdmin.register Order do
  menu :parent => "ORDERS", :priority => 2
  actions :index, :show, :destroy
  scope :all, :default => true
  scope "Standard" do |orders|
    orders.where(:payment_method => "Standard")
  end  
  scope "PayPal Express" do |orders|
    orders.where(:payment_method => "PayPal Express")
  end  
  scope "Free" do |orders|
    orders.where(:payment_method => "Free")
  end  

  
  # Configuration for Sidebar Filters
  filter :shopping_cart          
  filter :status, :as => :select, :collecrtion => ORDER_STATUSES   
  filter :card_type, as: :select, :collection => CREDIT_CARD_TYPE_SELECTION
  filter :email_sent, :as => :select                                       
  filter :email                                                            
  filter :order_number 
                                                                           
  
  # Configuration for Orders Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do 
    selectable_column      
    column :shopping_cart do |order|   
      link_to "Cart ##{order.shopping_cart_id}", admin_shopping_cart_path(order.shopping_cart_id)
    end
    column :order_number do |order|
      div :class => "admin-center-column" do  
        "##{order.order_number}" 
      end
    end
    column :payment_method do |order|      
      div :class => "admin-center-column" do  
        order.payment_method
      end
    end
    column :status, :sortable => :status do |order|
      div :class => "admin-center-column" do    
        order.status
      end
    end  
    column :email_sent, :sortable => :email_sent do |order|
      div :class => "admin-center-column" do 
        order.email_sent.yesno
      end
    end 
    column :created_at
    default_actions
  end      
  
  
  # Configuration for Orders Show Page
  show do |order|
    attributes_table do
      row :shopping_cart do |order|
        link_to "Cart ##{order.shopping_cart.id}", admin_shopping_cart_path(order.shopping_cart_id)
      end
      row :order_number do |order|
        "##{order.order_number}"
      end  
      row :payment_method
      row :status    
      row :email_sent do |order|
        order.email_sent.yesno
      end    
      unless order.payment_method == "Free"
        row "Transaction History" do
          table_for(order.transactions.reverse) do
            column :created_at
            column :action
            column :success, :sortable => :success do |transaction|
              transaction.success.yesno
            end            
            column :error_codes do |transaction|
              transaction.error_codes if transaction.error_codes != 0
            end
            column :message           
            column "View" do |transaction|
              link_to "View", admin_order_transaction_path(transaction.id)
            end
          end
        end
        row "Name" do |order|
         "#{order.first_name} #{order.last_name}" 
        end
        row "Address" do |order|
          "#{order.street1} #{order.street2}, #{order.city}, #{order.state}, #{order.country} #{order.zip}"
        end
        row :email  
        row :card_type
        row :card_expires_on 
        row :express_token
        row :express_payer_id
        row :ip_address
      end
      row :created_at  
    end
    active_admin_comments
  end
    
end

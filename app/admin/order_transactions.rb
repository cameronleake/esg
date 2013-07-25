ActiveAdmin.register OrderTransaction do
  menu :parent => "ORDERS", :priority => 3     
  actions :index, :show, :destroy
  scope :all, :default => true
  scope :successful do |transaction|
    transaction.where(:success => true)
  end
  scope :failed do |transaction|
    transaction.where(:success => false)
  end


  # Configuration for Sidebar Filters
  filter :order, :as => :select             
  filter :success, :as => :select     
  filter :error_codes
  filter :amount
  filter :action 


  # Configuration for Transactions Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do  
    selectable_column  
    column "Order", :sortable => :order_id do |transaction|
      link_to "##{transaction.order.order_number}", admin_order_path(transaction.order_id)
    end
    column :action, :sortable => :action do |transaction|
      div :class => "admin-center-column" do 
        transaction.action
      end
    end
    column :success, :sortable => :success do |transaction|
      div :class => "admin-center-column" do 
        transaction.success.yesno
      end
    end  
    column "Error Code" do |transaction|
      div :class => "admin-center-column" do   
        transaction.error_codes if transaction.error_codes != 0
      end
    end
    default_actions
  end    
            
  
  # Configuration for Transactions Show Page
  show do |transaction|
    attributes_table do
      row :order do |transaction|
        link_to "##{transaction.order.order_number}", admin_order_path(transaction.order_id)  
      end
      row :amount do |transaction|
        "$" + number_with_precision(transaction.amount.to_f/100, :precision => 2)  
      end
      row :action do |transaction|
        transaction.action        
      end
      row :success do |transaction|
        transaction.success.yesno        
      end
      row :message
      row :error_codes
      row :params
      row :created_at
    end
    active_admin_comments
  end
  
end

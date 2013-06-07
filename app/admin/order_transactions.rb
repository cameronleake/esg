ActiveAdmin.register OrderTransaction do
  menu :parent => "ORDERS", :priority => 3
  scope :all, :default => true
  scope :successful do |transaction|
    transaction.where(:success => true)
  end
  scope :failed do |transaction|
    transaction.where(:success => false)
  end
  

  # Configuration for Sidebar Filters
  filter :order
  filter :success, as: :select
  filter :action
  filter :amount
  filter :created_at


  # Configuration for Transactions Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :id
    column :action, :sortable => :action do |transaction|
      div :class => "admin-center-column" do 
        transaction.action
      end
    end
    column :amount, :sortable => :amount do |transaction|
      div :class => "admin-center-column" do 
        "$" + number_with_precision(transaction.amount.to_f/100, :precision => 2)
      end
    end
    column :success, :sortable => :success do |transaction|
      div :class => "admin-center-column" do 
        transaction.success.yesno
      end
    end
    default_actions
  end
  
end

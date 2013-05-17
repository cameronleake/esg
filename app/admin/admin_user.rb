ActiveAdmin.register AdminUser do
  menu :priority => 10
  menu :parent => "Users"
  scope :all, :default => true

  
  # Configuration for Sidebar Filters
  filter :email 
  filter :created_at
  filter :last_sign_in_at
  
  
  # Configuration for Admin Users Index Page
  config.sort_order = "last_sign_in_at_desc"
  config.per_page = 15
    
  index do                         
    column :email         
    column :last_sign_in_at           
    column :sign_in_count, :sortable => :sign_in_count do |admin_user|
      div :class => "admin-center-column" do 
        admin_user.sign_in_count
      end
    end           
    column :created_at
    default_actions                   
  end                                                      
  
  
  # Configuration for Admin Users Show Page
  show do |admin_user|
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :current_sign_in_at
      row :last_sign_in_at
      row :reset_password_sent_at  
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Admin Users Edit Page
  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end          
                          
end                                   

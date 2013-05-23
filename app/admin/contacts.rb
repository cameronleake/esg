ActiveAdmin.register Contact do
  menu :parent => "TICKETS", :label => "Contact Us", :priority => 1
  scope :all
  scope :open do |contact|
    contact.where(:status => "OPEN")
  end
  scope :closed do |contact|
    contact.where(:status => "CLOSED")
  end
  scope :spam do |contact|
    contact.where(:spam => true)
  end
  
  
  # Configuration for Sidebar Filters
  filter :status, :as => :select, :collection => ["OPEN", "CLOSED"]
  filter :spam, :as => :select
  filter :name
  filter :email
  filter :subject
  
  
  # Configuration for Tickets Index Page  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :status, :sortable => :status do |contact|
       div :class => "admin-center-column" do 
          contact.status
       end
    end  
    column :email       
    column :subject  
    column :created_at          
    default_actions                   
  end                                                      


  # Configuration for Tickets Show Page
  show do |contact|
    attributes_table do
      row :id
      row :status
      row :spam do |contact|
        contact.spam.yesno
      end
      row :name
      row :email
      row :subject
      row :body
      row :created_at
    end
    active_admin_comments
  end
    
  
  # Configuration for Tickets Index Page
  form do |f|                         
    f.inputs "New Contact Ticket" do       
      f.input :status, :as => :select, :include_blank => false, :collection => ["OPEN", "CLOSED"]
      f.input :spam, :as => :select, :include_blank => false
      f.input :name                
      f.input :email
      f.input :subject
      f.input :body
    end                               
    f.actions                         
  end          
  
end

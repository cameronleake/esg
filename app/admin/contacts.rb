ActiveAdmin.register Contact do
  menu :priority => 10
  menu :label => "Contact Tickets"
  
  filter :name
  filter :email
  filter :spam, :as => :select
  filter :subject
  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :id                            
    column :name                    
    column :email       
    column :subject
    column :spam, :sortable => :spam do |contact|
       div :class => "admin-center-column" do 
          contact.spam.yesno
       end
    end    
    column :created_at          
    default_actions                   
  end                                                      

  form do |f|                         
    f.inputs "New Contact Ticket" do       
      f.input :name                
      f.input :email
      f.input :subject
      f.input :body
      f.input :spam, :as => :select
    end                               
    f.actions                         
  end          
  
end

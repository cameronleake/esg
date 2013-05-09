ActiveAdmin.register Contact do
  menu :priority => 4
  menu :label => "Contact Tickets"
  
  filter :name
  filter :email
  filter :subject
  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :id                            
    column :name                    
    column :email       
    column :subject        
    column :created_at          
    default_actions                   
  end                                                      

  form do |f|                         
    f.inputs "Contact Ticket Details" do       
      f.input :name                
      f.input :email
      f.input :subject
      f.input :body
    end                               
    f.actions                         
  end          
  
  
end

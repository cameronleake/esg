ActiveAdmin.register AdminUser do
  menu :priority => 6

  filter :email  
  
  config.sort_order = "last_sign_in_at_desc"
  config.per_page = 15
    
  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                                      

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end          
                          
end                                   

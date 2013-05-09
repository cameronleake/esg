ActiveAdmin.register User do
   menu :priority => 3
   
   filter :email
   filter :email_verified
   filter :created_at
   filter :updated_at
   filter :password_reset_sent_at
   
   config.sort_order = "created_at_desc"
   config.per_page = 15
   
   index do
     selectable_column
     column :email
     column :email_verified, :sortable => :email_verified do |user|
       div :class => "email_verified" do 
         user.email_verified
       end
     end
     column :created_at
     column :updated_at
     column :password_reset_sent_at
     default_actions
   end
  
   form do |f|                         
     f.inputs "New User" do       
       f.input :email
       f.input :email_verified
       f.input :password
       f.input :password_confirmation
     end                               
     f.actions                         
   end
  
end

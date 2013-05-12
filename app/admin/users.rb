ActiveAdmin.register User do
   menu :priority => 2
   
   filter :first_name
   filter :last_name
   filter :email
   filter :email_verified
   filter :created_at
   
   config.sort_order = "created_at_desc"
   config.per_page = 15
   
   index do
     selectable_column
     column :first_name
     column :last_name
     column :email
     column :email_verified, :sortable => :email_verified do |user|
       div :class => "email_verified" do 
         user.email_verified
       end
     end
     column :created_at
     default_actions
   end
  
   form do |f|                         
     f.inputs "New User" do       
       f.input :first_name
       f.input :last_name
       f.input :email
       f.input :email_verified
       f.input :password
       f.input :password_confirmation
     end                               
     f.actions                         
   end
  
end

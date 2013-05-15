ActiveAdmin.register User do
   menu :priority => 2
   
   filter :first_name
   filter :last_name
   filter :email
   filter :created_at
   filter :email_verified, :as => :select
   filter :blog_subscription, :as => :select
   filter :resources_subscription, :as => :select
   
   config.sort_order = "created_at_desc"
   config.per_page = 15
   
   index do
     selectable_column
     column :first_name
     column :last_name
     column :email
     column :email_verified, :sortable => :email_verified do |user|
       div :class => "admin-center-column" do 
         user.email_verified.yesno
       end
     end
     column "Blog Sub.", :blog_subscription, :sortable => :blog_subscription do |user|
        div :class => "admin-center-column" do 
          user.blog_subscription.yesno
        end
     end
     column "Resource Sub.", :resources_subscription, :sortable => :resources_subscription do |user|
        div :class => "admin-center-column" do 
           user.resources_subscription.yesno
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
       f.input :email_verified, :as => :select
       f.input :password
       f.input :password_confirmation
       f.input :blog_subscription, :as => :select
       f.input :resources_subscription, :as => :select
       f.input :avatar, :as => :file
     end                               
     f.actions                         
   end
  
end

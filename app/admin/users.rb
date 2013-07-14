ActiveAdmin.register User do
  menu :parent => "USERS", :priority => 1
  scope :all, :default => true
  scope :email_not_verified do |users|
    users.where(:email_verified => false)
  end
  scope :blog_subscriptions do |users|
    users.where(:blog_subscription => true)
  end
  scope :resources_subscriptions do |users|
    users.where(:resources_subscription => true)
  end


  # Configuration for Sidebar Filters
  filter :first_name
  filter :last_name
  filter :email
  filter :created_at
  filter :email_verified, :as => :select
  filter :blog_subscription, :as => :select
  filter :resources_subscription, :as => :select


  # Configuration for Users Index Page
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
   selectable_column
   column :first_name
   column :last_name
   column :email
   column :created_at
   default_actions
  end
  
  
  # Configuration for Users Show Page
  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :email_verified do |user|
        user.email_verified.yesno
      end
      row :blog_subscription do |user|
        user.blog_subscription.yesno
      end
      row :resources_subscription do |user|
        user.resources_subscription.yesno
      end
      row :created_at
      row :updated_at
      row :password_reset_sent_at
      row :image do
        image_tag(user.avatar.url(:profile))
      end
      row :street1
      row :street2
      row :city
      row :state
      row :country
      row :zip
    end
    active_admin_comments
  end


  # Configuration for Users Edit Page
  form do |f|                         
   f.inputs "New User" do       
     f.input :first_name
     f.input :last_name
     f.input :email
     f.input :password
     f.input :password_confirmation
     f.input :email_verified, :as => :select, :include_blank => false
     f.input :blog_subscription, :as => :select, :include_blank => false
     f.input :resources_subscription, :as => :select, :include_blank => false
     f.input :avatar, :as => :file  
     f.input :street1
     f.input :street2
     f.input :city
     f.input :state
     f.input :country
     f.input :zip
   end                               
   f.actions                         
  end
  
end

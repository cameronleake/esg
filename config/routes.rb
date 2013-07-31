Esg::Application.routes.draw do

   root :to => "home#index"

   # HOME
   match 'faq' => 'home#faq'
   match '404' => 'home#404'
   match '422' => 'home#422'
   match '500' => 'home#500'


   # USERS / SESSIONS / PASSWORD_RESETS / EMAIL_VERIFICATIONS
   match "profile" => "users#edit"
   match 'signup' => 'users#new' 
   match 'login' => 'sessions#new'
   match 'logout' => 'sessions#destroy'
   get 'reset_password', to: 'password_resets#new', as: 'reset_password'
   resources :users, :only => [:index, :show, :new, :create, :edit, :update]
   resources :sessions, :only => [:new, :create, :destroy]
   resources :password_resets, :only => [:new, :create, :edit, :update]
   resources :email_verifications, :only => [:edit, :update] do
     member do
       get 'sendmessage'
     end
   end


   # ARTICLES / BLOG_COMMENTS
   match 'blog' => 'articles#index'
   get 'articles/tags/:tag', to: 'articles#index', as: :article_tag
   resources :articles, :only => [:index, :show, :edit, :update] do
    resources :blog_comments, :only => [:create]
    member { post :mercury_update }
   end


   # CATEGORIES / RESOURCES / REVIEWS / REQUESTS
   get 'categories/tags/:tag', to: 'categories#index', as: :category_tag
   get 'categories/:id/tags/:tag', to: 'categories#show', as: :show_category_tag
   get 'categories/:category_id/resources/:id/tags/:tag', to: 'resources#show', as: :show_resource_tag
   match 'resources/search' => 'resources#search'
   resources :categories, :only => [:index, :show] do
    resources :resources, :only => [:show, :search] do
      resources :reviews, :only => [:new, :create]
    end
   end                                          
   resources :requests


   # SHOPPING_CARTS / DOWNLOADS
   match 'shopping_cart' => 'shopping_carts#show'
   get 'resources/:id/add_to_cart', to: 'shopping_carts#add_to_cart', as: :add_to_cart
   get 'resources/:id/remove_from_cart', to: 'shopping_carts#remove_from_cart', as: :remove_from_cart
   get 'order_completed', to: 'orders#completed', as: :order_completed      
   get 'review_order', to: 'orders#review', as: :review_order     
   get 'downloads/:download_token', to: 'downloads#resource_download', as: :resource_download


   # ORDERS
   resources :orders    # <TODO> Clean up Routes for Checkout Process
   match 'review' => 'orders#review'      
   match 'payment_redirect' => 'orders#payment_redirect'
   match 'express' => 'orders#express'           
   match 'confirm_email' => 'orders#confirm_email'      
   match 'free_order' => 'orders#free_order'    
   match 'payment_failure' => 'orders#failure'
   

   # CONTACT_TICKETS
   match 'contact' => 'contacts#new'
   resources :contacts, :only => [:new, :create]
                                                     

   # BULK EMAIL
   match 'create_campaign' => 'bulk_email#create_campaign' 
   match 'send_campaign' => 'bulk_email#send_campaign' 


   # MERCURY_EDITOR
   namespace :mercury do
    resources :images
   end
   mount Mercury::Engine => '/'


   # ACTIVE_ADMIN
   ActiveAdmin.routes(self)
   devise_for :admin_users, ActiveAdmin::Devise.config


   # OTHER  
   match "/delayed_job" => DelayedJobWeb, :anchor => false

end

Esg::Application.routes.draw do

   root :to => "home#index"

   # HOME
   match 'ebook' => 'home#ebook'
   match 'resourcecentre' => 'home#resource_centre'
   match 'faq' => 'home#faq'
   match '404' => 'home#404'
   match '422' => 'home#422'
   match '500' => 'home#500'


   # USERS / SESSIONS / PASSWORD_RESETS / EMAIL_VERIFICATIONS
   match "profile" => "users#edit"
   match 'signup' => 'users#new'
   match 'subscribe_blog' => 'users#subscribe_blog'
   match 'subscribe_resources' => 'users#subscribe_resources'  
   match 'login' => 'sessions#new'
   match 'logout' => 'sessions#destroy'
   get 'reset_password', to: 'password_resets#new', as: 'reset_password'
   resources :users
   resources :sessions
   resources :password_resets
   resources :email_verifications do
    member do
      get 'sendmessage'
    end
   end


   # ARTICLES / BLOG_COMMENTS
   match 'blog' => 'articles#index'
   get 'articles/tags/:tag', to: 'articles#index', as: :article_tag
   resources :articles do
    resources :blog_comments
    member { post :mercury_update }
   end


   # CATEGORIES / RESOURCES / REVIEWS / DOWNLOADS
   get 'categories/tags/:tag', to: 'categories#index_filtered', as: :category_tag
   get 'categories/:id/tags/:tag', to: 'categories#show_filtered', as: :show_category_tag
   get 'categories/:category_id/resources/:id/tags/:tag', to: 'resources#show_filtered', as: :show_resource_tag
   match 'resources/search' => 'resources#search'
   resources :categories do
    resources :resources do
      resources :reviews
      resources :downloads
    end
   end


   # SHOPPING_CARTS
   resources :shopping_carts 
   match "cart" => "shopping_carts#show"
   get 'resources/:id/add_to_cart', to: 'shopping_carts#add_to_cart', as: :add_to_cart
   get 'resources/:id/remove_from_cart', to: 'shopping_carts#remove_from_cart', as: :remove_from_cart


   # CONTACT_TICKETS
   match 'contact' => 'contacts#new'
   resources :contacts


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

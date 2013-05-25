Esg::Application.routes.draw do

  root :to => "home#index"

  # HOME
  match 'ebook' => 'home#ebook'
  match 'resourcecentre' => 'home#resource_centre'
  match 'faq' => 'home#faq'
  match '404' => 'home#404'
  match '422' => 'home#422'
  match '500' => 'home#500'
  
  
  # USERS / SESSIONS / PASSWORD RESETS / EMAIL_VERIFICATIONS
  match "profile" => "users#edit"
  match 'signup' => 'users#new'
  match 'subscribe_blog' => 'users#subscribe_blog'
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


  # ARTICLES / BLOG COMMENTS
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
  resources :categories do
    resources :resources do
      resources :reviews
      resources :downloads
    end
  end
  
  
  # CONTACT TICKETS
  match 'contact' => 'contacts#new'
  resources :contacts


  # MERCURY EDITOR
  namespace :mercury do
    resources :images
  end
  mount Mercury::Engine => '/'


  # ACTIVE ADMIN
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  
  # OTHER  
  match "/delayed_job" => DelayedJobWeb, :anchor => false

end

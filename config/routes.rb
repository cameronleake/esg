Esg::Application.routes.draw do

  root :to => "home#index"

# HOME
  match 'ebook' => 'home#ebook'
  match 'resourcecentre' => 'home#resource_centre'
  match 'faq' => 'home#faq'
  match '404' => 'home#404'
  match '422' => 'home#422'
  match '500' => 'home#500'
  
# ARTICLES / BLOG COMMENTS
  match 'blog' => 'articles#index'
  get 'tags/:tag', to: 'articles#index', as: :tag
  resources :articles do
    resources :blog_comments
    member { post :mercury_update }
  end
  
# USERS
  match "profile" => "users#edit"
  match 'signup' => 'users#new'
  match 'subscribe_blog' => 'users#subscribe_blog'
  match 'login' => 'sessions#new'
  resources :users
  
# SESSIONS
  match 'logout' => 'sessions#destroy'
  resources :sessions
  
# CONTACTS
  match 'contact' => 'contacts#new'
  resources :contacts
  
# PASSWORD_RESETS
  get 'reset_password', to: 'password_resets#new', as: 'reset_password'
  resources :password_resets
  
# EMAIL_VERIFICATIONS
  resources :email_verifications do
    member do
      get 'sendmessage'
    end
  end

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

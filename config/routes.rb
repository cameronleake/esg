Esg::Application.routes.draw do

  root :to => "home#index"
  
  match 'ebook' => 'home#ebook'
  match 'resourcecentre' => 'home#resource_centre'
  match 'blog' => 'articles#index'
  match 'faq' => 'home#faq'
  match "profile" => "users#show"
  match 'signup' => 'users#new'
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'
  match 'contact' => 'contacts#new'
  
  match '404' => 'home#404'
  match '422' => 'home#422'
  match '500' => 'home#500'  

  get 'users', to: 'users#show', as: 'users'
  
  resources :users
  resources :articles
  resources :sessions
  resources :password_resets
  resources :contacts
  resources :email_verifications do
    member do
      get 'sendmessage'
    end
  end

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  match "/delayed_job" => DelayedJobWeb, :anchor => false

end

require 'sidekiq/web'

Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/kadmin', as: 'rails_admin'
  # access to the jobs in the queue domainapp/sidekiq
  mount Sidekiq::Web, at:'/sidekiq'

  scope '(:locale)', :locale => /en|es/ do

  namespace :admin do

    get '/dashboard', to: "dashboard#index", as: :admin_dashboard_path

    resources :recommended_feeds
    resources :categories

  end

  root :to => "feed_entry#index"
  get '/dashboard', to: "feed_entry#dashboard"
  
  resources :feedlists
  get "/feeds" => "feedlists#actualiza", via: [:get, :post]
  get "/tagged_feedlist" => "feedlists#tagged", as: :tagged_feedlist
  get "/search_feedlist" => "feedlists#search", as: :search_feedlist

  get 'tags/:tag', to: 'bookmarks#tagged', as: :tag
  get 'tagged' => 'bookmarks#tagged', :as => 'tagged'

  get 'tagged_feed/:tag', to: 'feeds#tagged_feed', as: :tagged_feed
  post "/update_all_feeds" => "feeds#update_all_feeds"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: "devise/sessions"}, skip: :omniauth_callbacks
  resources :users, :only => [:index]

  # override devise url snippet
  devise_scope :users do

    get ':id' => 'users#show'
    
  end

  get 'users/sign_in', :to => 'devise/sessions#new', via: [:get, :post]

  get 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/failure', to: redirect('/'), via: [:get, :post]
  post 'signout', to: 'sessions#destroy', as: 'signout'

  resources :bookmarks
  
  resources :users do
    resources :bookmarks
  end
  
  resources :users do
    resources :feeds do
      resources :feedlists do
      end
    end
  end

  resources :users do
    resources :feeds do
     end
  end

  end # close i18N scope 
end
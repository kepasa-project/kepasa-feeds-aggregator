require 'sidekiq/web'

Rails.application.routes.draw do
  
  # access to the jobs in the queue domainapp/sidekiq
  mount Sidekiq::Web, at:'/sidekiq'

  scope '(:locale)', :locale => /en|es|it|tl/ do

  namespace :admin do

    get '/dashboard', to: "dashboard#index", as: :dashboard
    
    resources :categories
    resources :recommended_feeds
    
        
  end
  # end snippet to delete

  resources :categories do 
    resources :recommended_feeds
  end
  
  root :to => "feed_entry#index"
  get "/dashboard", to: "feed_entry#dashboard"
  get "/content", to: "feed_entry#content"

  resources :feedlists
  get "/feeds" => "feeds#actualiza", via: [:get, :post]
  get "/tagged_feedlist" => "feedlists#tagged", as: :tagged_feedlist
  get "/search_feedlist" => "feedlists#search", as: :search_feedlist

  get 'tags/:tag', to: 'bookmarks#tagged', as: :tag
  get 'tagged' => 'bookmarks#tagged', :as => 'tagged'

  get 'tagged_feed/:tag', to: 'feeds#tagged_feed', as: :tagged_feed
  post "/update_all_feeds" => "feeds#update_all_feeds"
  
  post 'add_feed', to: 'feeds#add_feed', as: :add_feed

  devise_for :users, :controllers => { sessions: "devise/sessions"}
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

  end # close I18n scope 
end
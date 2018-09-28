require 'sidekiq/web'

Rails.application.routes.draw do
  
  resources :feedlists

  resources :conversations, only: [:index, :show, :destroy]

  resources :messages, only: [:new, :create]
  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :restore
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    collection do
      post :empty_trash
    end
  end

  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :mark_as_read
    end
  end
  
  # access to the jobs in the queue domainapp/sidekiq
  mount Sidekiq::Web, at:'/sidekiq'

  get 'tags/:tag', to: 'bookmarks#tagged', as: :tag
  
  get 'tagged' => 'bookmarks#tagged', :as => 'tagged'

  get 'tagged_feed/:tag', to: 'feeds#tagged_feed', as: :tagged_feed

  get "/feeds" => "feedlists#actualiza", via: [:get, :post]
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: "devise/sessions"} 
  
  resources :users, :only => [:index]

  # override devise url snippet
  devise_scope :users do

    get ':id' => 'users#show'
    
  end

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

  get 'users/sign_in', :to => 'devise/sessions#new', via: [:get, :post]

  get 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/failure', to: redirect('/'), via: [:get, :post]
  post 'signout', to: 'sessions#destroy', as: 'signout'

  resources :newspapers do
      collection { post :sort }
  end

  resources :users do
      member do
        get :following, :followers
      end
   end

  resources :users, :only => [:show]
  
  resources :relationships, :only => [:new, :create, :destroy]

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "feed_entry#index"

  ActiveAdmin.routes(self)
  
  resources :following_relationships, :only => [:create, :destroy]

end
require 'sidekiq/web'

Futbol::Application.routes.draw do
  
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

  #mount Monologue::Engine, at: '/blog' 
  
  # access to the jobs in the queue domainapp/sidekiq
  mount Sidekiq::Web, at:'/sidekiq'

  get 'tags/:tag', to: 'bookmarks#tagged', as: :tag
  
  match 'tagged' => 'bookmarks#tagged', :as => 'tagged'  
  
  get 'tagged_feed/:tag', to: 'feeds#tagged_feed', as: :tagged_feed

  #match 'tagged_feed' => 'feeds#tagged_feed', :as => 'tagged_feed' 
  #resources :articles
  #root to: 'articles#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", sessions: "devise/sessions"} 
  
  # override devise url snippet
  #devise_scope do

  #  get ':id' => 'users#show'

  #end  
  
  # se non metto questo non mi funziona l'inserimento dei bookmarks come nested resources
  resources :bookmarks#, :only => [:create, :edit, :update]

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

  match 'users/sign_in', :to => 'devise/sessions#new'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

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
  
  match "/feeds" => "feedlists#actualiza", via: [:get, :post]
  
  resources :following_relationships, :only => [:create, :destroy]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

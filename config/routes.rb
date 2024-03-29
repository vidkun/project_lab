Rails.application.routes.draw do

  namespace :admin do
    get 'stats', to: 'stats#index', as: 'stats'
  end

  get 'project_members/new'

  get 'project_members/create'

  get 'project_members/destroy'

  get 'apis/callback', to: 'apis#github_callback', as: 'github_callback'

  root 'projects#index'
 

  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "apis" }

  # devise_scope :user do
  #   get '/apis', to: 'apis#main'
  # end

  resources :projects do
    resources :tasks
    resources :project_members, :only => [:new, :create, :destroy]
  end

  resources :users, :only => [:show, :index]

  namespace :admin do
    resources :projects, only: [:index]
    resources :users
  end

  get 'admin/projects/expire_cache' => 'admin/projects#expire_cache'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

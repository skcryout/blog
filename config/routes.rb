VingleBlog::Application.routes.draw do
  root 'pages#home'
  get '/sign_up' => 'pages#sign_up'
  get '/sign_in' => 'pages#sign_in'
  get '/posts/new' => 'pages#posts_new'
  get '/:username' => 'pages#blog'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      
      post 'sessions' => 'sessions#create'
      delete 'sessions' => 'sessions#destroy'
      post 'sessions/check_auth_token' => 'sessions#check_auth_token'
      
      get 'posts/:username' => "posts#personal"
      post 'posts' => 'posts#create'
      delete 'posts' => 'posts#destroy'
      
      
      resources :comments, only: [:create]
      resources :tags, only: [:create]

      get 'title' => "title#number_of_posts_and_users"
    end
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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

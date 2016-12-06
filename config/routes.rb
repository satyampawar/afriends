Rails.application.routes.draw do




  # get 'photos/create'

  # get 'photos/index'

  # get 'photos/new'

  # get 'photos/destroy'

  # get 'photos/show'

  # get 'albums/create'

  # get 'albums/index'

  # get 'albums/new'

  # get 'albums/destroy'

  # get 'albums/show'









mount Soulmate::Server, :at => "/autocomplete"
  get "/photochange" => "users#photochange"

 devise_for :users ,controllers: { registrations: 'registrations' ,:omniauth_callbacks => "callbacks"} 
 resources :users do
  

  resources :friendlog
   resources :posts do
    resources :likes


   end 
   resources :albums  do
     resources :photos
     member do
      get "lock_album"
     end
   end
 end
 
  resources :conversations do
    resources :messages
  end
#  ddevise_scope :user do
#   get "/users/invitation/accept", :to => "devise/invitations#edit",   :as => 'accept_user_invitation'
#   put "/users/confirmation",        :to => "devise/invitations#update", :as => nil
# end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'
   resources :phone_numbers, only: [:new, :create]
  get '/change_emotion' => "welcome#change_emotion" , as: :change_emotion
  get '/who_is_online' => "welcome#who_is_online" , as: :who_is_online
  get '/get_ip_machine' => "welcome#get_ip_machine" , as: :get_ip_machine
  get '/:user_id/create_page' => 'users#create_page' ,as: :create_page
  get "/search_movies" => "users#search_movies"
  get 'phone_numbers/new_verify' => "phone_numbers#new_verify" , as: :new_verify
  post 'users/update_profile' => "users#update_profile", as: :update_profile
  post 'users/update_cover' => "users#cover_pic", as: :update_coverpic
  post '/verify_account/:session_id' => "users#verify_account", as: :verify_account
  post '/user_details' => "users#user_details", as: :user_details
  get '/fixposition' => 'users#fixposition', as: :cover_fixposition
  

  post 'phone_numbers/verify' => "phone_numbers#verify"
  get '/:user_id/profile-page' => 'users#profile_page' ,as: :user_profile
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

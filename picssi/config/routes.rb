Rails.application.routes.draw do



  get "/photochange" => "users#photochange"

 devise_for :users ,controllers: { registrations: 'registrations'} 
 resources :users do
   resources :posts do
    resources :likes
   end 
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
   get 'phone_numbers/new_verify' => "phone_numbers#new_verify" , as: :new_verify
   post 'users/update_profile' => "users#update_profile", as: :update_profile
   post '/verify_account/:session_id' => "users#verify_account", as: :verify_account
  post '/user_details' => "users#user_details", as: :user_details


  post 'phone_numbers/verify' => "phone_numbers#verify"
  get '/profile-page' => 'users#profile_page'
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

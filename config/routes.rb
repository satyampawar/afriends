Rails.application.routes.draw do
mount Soulmate::Server, :at => "/autocomplete"
  get "/photochange" => "users#photochange"
  get "/remove_tag_user" => "tags#remove_tag_user",  as: :remove_tag_user

 devise_for :users ,controllers: { registrations: 'registrations', sessions: 'sessions' ,:omniauth_callbacks => "callbacks"} 
 resources :users do

  member do 
    get "block"
  end
  resources :settings do 
   collection do 
    get "block_list"
   end
  end

  resources :pages
  resources :friendlog
   resources :posts do
    resources :comments
    resources :likes
    resources :tags 
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
  match '/setting_up/:id', :to => "video_chat#setting_up", :as => :setting_up, :via => :get
  match '/party/:id', :to => "video_chat#party", :as => :party, :via => :get
   root 'welcome#index'
   resources :phone_numbers, only: [:new, :create]
  get '/change_emotion' => "welcome#change_emotion" , as: :change_emotion
  get '/second_change_emotion' => "welcome#second_change_emotion" , as: :second_change_emotion
  get '/who_is_online' => "welcome#who_is_online" , as: :who_is_online
  get '/search_user' => "welcome#search_user" , as: :search_user
  get '/get_ip_machine' => "welcome#get_ip_machine" , as: :get_ip_machine
  get '/:user_id/create_page' => 'users#create_page' ,as: :create_page
  get "/search_movies" => "users#search_movies"
  get "/friends_list" => "users#friends_list"
  get 'phone_numbers/new_verify' => "phone_numbers#new_verify" , as: :new_verify
  post 'users/update_profile' => "users#update_profile", as: :update_profile
  post 'users/update_cover' => "users#cover_pic", as: :update_coverpic
  post '/verify_account/:session_id' => "users#verify_account", as: :verify_account
  post '/user_details' => "users#user_details", as: :user_details
  get '/fixposition' => 'users#fixposition', as: :cover_fixposition
  

  post 'phone_numbers/verify' => "phone_numbers#verify"
  get '/:user_id/profile-page' => 'users#profile_page' ,as: :user_profile
  get '/count_notifications' => 'notifications#count_notifications' ,as: :count_notifications
  get '/birthday_notification' => 'notifications#birthday_notification' ,as: :birthday_notification

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

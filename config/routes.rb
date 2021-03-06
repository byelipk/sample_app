SampleApp::Application.routes.draw do
  root to: "static_pages#home"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_confirmations, only: [:new, :edit]
  resources :signup_form, only: [:new, :create]
  
  match '/help',      to: 'static_pages#help'
  match '/about',     to: 'static_pages#about'
  match '/contact',   to: 'static_pages#contact'
  
  match '/signup',    to: 'users#new',         via: 'get'
  match '/signup',    to: 'users#new',         via: 'post'
  match '/signin',    to: 'sessions#new',      via: 'get'
  match '/signout',   to: 'sessions#destroy',  via: 'delete'


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
#== Route Map
# Generated on 24 Nov 2013 10:49
#
#                     users GET    /users(.:format)                          users#index
#                           POST   /users(.:format)                          users#create
#                  new_user GET    /users/new(.:format)                      users#new
#                 edit_user GET    /users/:id/edit(.:format)                 users#edit
#                      user GET    /users/:id(.:format)                      users#show
#                           PUT    /users/:id(.:format)                      users#update
#                           DELETE /users/:id(.:format)                      users#destroy
#                  sessions POST   /sessions(.:format)                       sessions#create
#               new_session GET    /sessions/new(.:format)                   sessions#new
#                   session DELETE /sessions/:id(.:format)                   sessions#destroy
#           password_resets POST   /password_resets(.:format)                password_resets#create
#        new_password_reset GET    /password_resets/new(.:format)            password_resets#new
#       edit_password_reset GET    /password_resets/:id/edit(.:format)       password_resets#edit
#            password_reset PUT    /password_resets/:id(.:format)            password_resets#update
#  new_account_confirmation GET    /account_confirmations/new(.:format)      account_confirmations#new
# edit_account_confirmation GET    /account_confirmations/:id/edit(.:format) account_confirmations#edit
#         signup_form_index POST   /signup_form(.:format)                    signup_form#create
#           new_signup_form GET    /signup_form/new(.:format)                signup_form#new
#                      help        /help(.:format)                           static_pages#help
#                     about        /about(.:format)                          static_pages#about
#                   contact        /contact(.:format)                        static_pages#contact
#                    signup GET    /signup(.:format)                         users#new
#                           POST   /signup(.:format)                         users#new
#                    signin GET    /signin(.:format)                         sessions#new
#                   signout DELETE /signout(.:format)                        sessions#destroy

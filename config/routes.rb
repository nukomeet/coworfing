Coworfing::Application.routes.draw do
  
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    match 'about' => 'home#about', via: :get, as: :about

    match 'home/location' => 'home#location'

    match 'map' => 'home#map', via: :get, as: :map
    match 'search/places' => 'home#places', via: [:get, :post], as: :list

    match 'profile/:username' => 'users#show', via: :get, as: :profile
    match 'people' => 'users#index', via: :get, as: :people

    devise_for :users, skip: [:sessions], controllers: { invitations: 'users/invitations', registrations: 'registrations' }
    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    end
    
    devise_for :users do
      match "/users/password/edit" => "devise_passwords#edit" 
    end

    resources :places do 
      resources :comments
    end

    resources :demands
    resources :place_requests, path: 'requests' do
      get 'approve', on: :member
      get 'reject', on: :member
      get 'received', on: :collection
      get 'sent', on: :collection
    end

    match '/:locale' => 'home#index' 

    root :to => "home#index"

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
  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  match '', to: redirect("/#{I18n.default_locale}")
end

Rails.application.routes.default_url_options[:locale] = I18n.locale 

Coworfing::Application.routes.draw do
    match 'about' => 'home#about', via: :get, as: :about
    
    match 'contribute' => 'home#contribute', via: :get, as: :contribute

    match 'home/location' => 'home#location'

    match 'map' => 'home#map', via: :get, as: :map

    match 'profile/:username' => 'users#show', via: :get, as: :profile
    match 'people' => 'users#index', via: :get, as: :people

    devise_for :users, skip: [:sessions], controllers: { invitations: 'users/invitations', registrations: 'registrations' }
    as :user do
      get 'login' => 'devise/sessions#new', as: :new_user_session
      post 'login' => 'devise/sessions#create', as: :user_session
      delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session

      # TODO: Why I cannot use get/put here ? :locale error
      match 'settings/edit' => 'settings#edit', via: :get, as: :user_settings_edit
      match 'settings' => 'settings#update', via: :put, as: :user_settings_update

      match "password/edit" => 'settings/password#edit', as: :user_password_edit
      match "password" => 'settings/password#update', via: :put, as: :user_password_update
    end
    
    authenticated :user do
        root to: 'home#map'
    end

    resources :users


    resources :places do 
      resources :comments, :only => :create

      get 'submitted', on: :collection, as: :submitted
      get 'page/:page', action: :index, on: :collection
    end

    resources :demands, :only => [:create, :index] do 
      put "accept", on: :member
    end
    
    resources :place_requests, path: 'requests' do
      get 'approve', on: :member
      get 'reject', on: :member
      get 'received', on: :collection
      get 'sent', on: :collection
    end

    root :to => "home#index"
end


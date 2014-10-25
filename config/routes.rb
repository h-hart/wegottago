GottaGo::Application.routes.draw do

  get 'splash' => 'home#email_capture'
  post 'reservation' => 'reservation#create'

  resources :cities, only: [:show]

  resources :interests, only: [:show]

  get "comments/:id", to: 'comments#show'
  post "comments" => 'comments#create'

  get "conversations/get-status/:id", to: 'conversations#get_status'
  get "conversations/update-status", to: 'conversations#update_status'
  resources :conversations do
    get :autocomplete_user_name, on: :collection
  end

  get "theme/:id", to: 'theme#show'
  post "theme" => 'theme#create', :as => :create_theme

  get "theme_category", to: 'theme_category#index'

  resources :activity_categories, only: [:index] do
    get "activities/end-time(/:time)", to: 'activities#end_time'
    get "activities/explore", to: 'activities#explore', :as => :activities_explore
  end
  get "activities/explore", to: 'activities#explore', :as => :activities_explore
  get "activities/:user_id/user", to: 'activities#index', :as => :user_activities
  resources :activities, only: [:index, :show, :create]

  get "activity-join/:id", to: 'activity_join#join'
  
  get "curiosities", to: 'curiosity#index', :as => :curiosities
  get "curiosity/:id", to: 'curiosity#curious'

  resources :notifications, only: [:index]

  resources :friends, only: [:index, :show] do
    member do
      get :requests, to: 'friends#requests'
    end
    collection do
      get :explore, to: 'friends#explore'
    end
  end
  resources :friendships, only: [:create, :update, :destroy]

  resources :activity_categories, only: [:index, :show]

  resources :profiles, only: [:show, :index]
  resources :signup_wizard

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get 'authenticate', to: 'home#index', as: :authenticate
  devise_for :users, :controllers => {
    :omniauth_callbacks => "omniauth_callbacks",
    :registrations      => "registrations",
    :sessions           => "sessions",
    :passwords          => "passwords",
    :confirmations      => "confirmations"
  }
  as :user do 
    get "/profile/edit" => "registrations#edit", as: :edit_user_profile
    get "/users"             => "registrations#edit"
  end
  devise_scope :user do #custom devise controller actions
    post :remove_avatar, 
         to: 'registrations#remove_avatar', 
         as: :remove_avatar
  end

  authenticated :user do
    root :to => "cities#show", as: :authenticated_root, defaults: { name: 'Los Angeles, CA, United States' }
  end
  root :to => "cities#show", defaults: { name: 'Los Angeles, CA, United States' }

end

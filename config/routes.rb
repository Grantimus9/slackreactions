Rails.application.routes.draw do

  # Root. I AM (G)ROOT
  root 'static_pages#index'

  # Static pages
  get 'static_pages/index'

  # User Model
  resources :users
  resources :reactions

  # Omniauth And Google OAUTH Callbacks
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'static_pages#security'

end

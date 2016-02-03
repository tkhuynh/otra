Rails.application.routes.draw do 

  root to: 'application#home'

  resources :users, except: [:show, :destroy]
  resources :bands, only: [:show, :update]
  resources :hosts, only: :show
  resources :tours
  resources :shows
  resources :performances, only: [:index, :show, :update]
  resources :requests, only: [:create, :update]

  get '/band_dashboard', to: 'bands#dashboard'
  get '/host_dashboard', to: 'hosts#dashboard'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
end

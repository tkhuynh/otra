Rails.application.routes.draw do

  root to: 'users#new'

  resources :users, except: [:show, :destroy]
  resources :bands, only: :show
  resources :hosts, only: :show
  resources :tours
  resources :performances

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
end

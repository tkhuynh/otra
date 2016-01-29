Rails.application.routes.draw do

  get 'tours/index'

  get 'tours/show'

  get 'tours/new'

  get 'tours/edit'

  root to: 'users#new'

  resources :users, except: :show
  resources :bands, only: :show
  resources :hosts, only: :show

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
end

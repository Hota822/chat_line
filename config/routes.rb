Rails.application.routes.draw do


  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sesisons#create'
  delete '/login', to: 'sessions#destroy'
  resources :users
end

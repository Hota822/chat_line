Rails.application.routes.draw do


  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    collection do
      get 'search',  to: 'users#search'
      get 'result', to: 'users#result'
    end
    member do
      get  '/friendrequest', to: 'friendships#new'
      post '/friendrequest', to: 'friendships#friendrequest'
      get  '/friendship', to: 'friendships#new'
      post '/friendship', to: 'friendships#create'
      get  '/friendlist', to: 'friendships#index'
    end
  end
end

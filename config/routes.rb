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
      get  '/friendrequest', to: 'friend_requests#show'
      post '/friendrequest', to: 'friend_requests#create'
      post '/friendrelation', to: 'friend_relations#create'
      get  '/friendships', to: 'users#index'
    end
  end
  resources :talk_rooms do
    member do
      get  '/invite', to: 'user_talkroom_relations#new'
      post '/invite', to: 'user_talkroom_relations#create'
      post '/symbols',to: 'talk_rooms#symbols'
      post '/calculate', to:'talk_rooms#calculate'
      get  '/setting',to: 'talk_rooms#edit'
      patch '/setting',to: 'talk_rooms#update'
    end
  end
  resources :talks
  get  'attempt', to: 'talk_rooms#attempt'
  post 'attempt', to: 'talk_rooms#attemptpost'

end

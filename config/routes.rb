Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root "businesses#index"
  get '/home', to: 'businesses#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
  
  resources :businesses, only: [:index, :show, :new, :create]
  resources :users, only: [:create]
end

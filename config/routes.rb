Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root "businesses#index"
  get '/home', to: 'businesses#index'
  get '/sign_up', to: 'users#new'
  
  resources :businesses, only: [:index, :show, :new, :create]
  resources :users, only: [:create]
end

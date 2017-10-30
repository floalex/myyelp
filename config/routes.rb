Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root "businesses#index"
  get '/home', to: 'businesses#index'
  
  resources :businesses, only: [:index, :show, :new, :create]
end

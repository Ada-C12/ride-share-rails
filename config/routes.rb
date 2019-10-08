Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'homepages#index'
  # get '/home', to: 'homepages#index', as "home"
  
  patch '/drivers/:id/toggle', to: 'drivers#toggle_active', as: 'toggle_active'
  resources :drivers
  
  # get '/passengers/:id/request', to: 'passengers#request_trip', as: 'request_trip'
  resources :passengers
  
  
  resources :trips, except: [:index, :new]
end

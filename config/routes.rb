Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'homepages#index'
  # get '/home', to: 'homepages#index', as "home"
  
  patch '/drivers/:id/toggle', to: 'drivers#toggle_active', as: 'toggle_active'
  resources :drivers
  
  resources :passengers
  
  resources :passengers do
    resources :trips, only: [:create]
  end
  # => passenger_trips POST   /passengers/:passenger_id/trips(.:format)   trips#create
  
  
  resources :trips, except: [:index, :new]
end

Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips
  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
end
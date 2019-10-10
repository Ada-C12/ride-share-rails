Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips, only: [:show,]
  
  resources :passengers, only: [:index, :show] do
    resources :trips, only: [:create]
  end
  
  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
end
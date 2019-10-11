Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips, only: [:show, :update]
  
  resources :passengers, only: [:index, :show, :new, :create] do
    resources :trips, only: [:index, :create, :show]
  end
  
  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
end
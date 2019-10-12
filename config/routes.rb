Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips, only: [:show, :edit, :update, :destroy]

  resources :passengers, only: [:show] do
    resources :trips, only: [:create, :show]
  end

  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
end
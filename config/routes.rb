Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips, except: [:new]

  resources :passengers, only: [:show] do
    resources :trips, only: [:create, :edit, :show]
  end

  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
end
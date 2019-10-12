Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :passengers
  resources :passengers, only: [:show] do
    resources :trips, only: [:create, :edit, :destroy]
  end 
  resources :drivers
  resources :trips, only: [:show, :destroy]
  
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  patch '/trip/:id/complete_trip', to: 'trips#complete_trip', as: 'complete_trip'
  
end

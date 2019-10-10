Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "homepages#index"
  
  resources :homepages
  
  resources :drivers
  patch '/drivers/:id/status', to: 'drivers#status', as: 'driver_status'
  
  resources :passengers do
    resources :trips, only: [:new, :create]
  end
  
  resources :trips
  
end

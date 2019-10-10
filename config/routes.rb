Rails.application.routes.draw do
  
  resources :drivers
  resources :passengers do
    resources :trips, only: [:new, :create]
  end
  resources :trips
  
  root "homepages#index"
  
end

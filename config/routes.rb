Rails.application.routes.draw do
  root "homepages#index"
  
  resources :drivers
  resources :passengers do
    resources :trips, only: [:create]
  end
  
  resources :trips
  
end

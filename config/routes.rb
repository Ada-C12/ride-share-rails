Rails.application.routes.draw do
  
  resources :drivers
  resources :passengers
  resources :trips
  
  root "homepages#index"
  
end

Rails.application.routes.draw do
  
  resources :drivers
  
  root "homepages#index"
  
end

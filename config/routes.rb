Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # root :to "determine a root thing, sometime"
  
  resources :trips
  
  resources :drivers
  
  resources :passengers
  
end

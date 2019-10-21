Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "application#index"

  post "trips/:passenger_id", to: "trips#create", as: "new_trip"
  resources :trips
  
  resources :drivers
  
  resources :passengers
  
end

Rails.application.routes.draw do
  root "homepages#index"
  
  patch "/driver/:id/toggle", to: "drivers#toggle", as: "toggle"
  
  resources :drivers
  resources :passengers do
    resources :trips, only: [:create]
  end
  
  resources :trips
  
end

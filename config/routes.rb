Rails.application.routes.draw do

  root to: "homepages#index"

  resources :drivers
  resources :passengers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

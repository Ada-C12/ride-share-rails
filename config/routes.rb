Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => "homepages#index"

  get "drivers/unavailable", to: "drivers#not_found", as: :driver_not_found


  resources :passengers do
    resources :trips, only: [:index, :new, :create]
  end

  resources :drivers do
    resources :trips, only: [:index, :new]
  end

  
  resources :homepages, only: [:index]
  resources :trips


end

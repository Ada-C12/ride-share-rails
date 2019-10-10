Rails.application.routes.draw do
  root "homepages#index"

  resources :drivers do 
    resources :trips, only: [:index]
  end

  patch "/drivers/:id/available", to: "drivers#toggle_available", as: "make_available"

  patch "/drivers/:id/unavailable", to: "drivers#toggle_unavailable", as: "make_unavailable"

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :trips, except: [:create, :new]
end

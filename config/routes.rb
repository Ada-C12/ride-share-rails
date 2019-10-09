Rails.application.routes.draw do
  root "homepages#index"

  resources :drivers
  # get "/drivers", to: "drivers#index", as: :drivers
  # post "/drivers", to: "drivers#create"
  # get "/drivers/new", to: "drivers#new", as: :new_driver
  # get "/drivers/:id", to: "drivers#show", as: :driver
  # patch "/drivers/:id", to: "drivers#update"
  # delete "/drivers/:id", to: "drivers#destroy"
  # get "/drivers/:id/edit", to: "drivers#edit", as: :edit_driver

  resources :passengers do
    resources :trips, only: [:index, :create]
  end

  resources :trips, except: [:create, :new]

  # get "/passengers", to: "passengers#index", as: :passengers
  # post "/passengers", to: "passengers#create"
  # get "/passengers/new", to: "passengers#new", as: :new_passenger
  # get "/passengers/:id", to: "passengers#show", as: :passenger
  # patch "/passengers/:id", to: "passengers#update"
  # delete "/passengers/:id", to: "passengers#destroy"
  # get "/passengers/:id/edit", to: "passengers#edit", as: :edit_passenger

  # get "/trips", to: "trips#index", as: :trips
end

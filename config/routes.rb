Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "passengers#index", as: "root_passengers"
  #resources :passengers, except: [:edit]
  # get "/passengers", to: "passengers#index", as: "passengers"
  # get "/passengers/new", to: "passengers#new", as: "new_passenger"
  # post "/passengers", to: "passengers#create", as: "create_passenger"
  # patch "/passengers/:id/toggle_completed", to: "passengers#toggle_completed", as: "toggle_completed_passenger"
  # get "/passengers/:id/edit", to: "passengers#edit", as: "edit_passenger"
  # get "/passengers/:id", to: "passengers#show", as: "passenger"
  # patch "/passengers/:id", to: "passengers#update", as: "update_passenger"
  # delete "/passengers/:id", to: "passengers#destroy"
  resources :passengers

  root to: "drivers#index", as: "root_drivers"
  resources :drivers

  root to: "trips#index", as: "root_trips"
  resource :trips

  root to: "homepages#index"
  resource :homepages
end

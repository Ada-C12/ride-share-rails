Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "passengers#index"
  #resources :tasks, except: [:edit]
  # get "/tasks", to: "tasks#index", as: "tasks"
  # get "/tasks/new", to: "tasks#new", as: "new_task"
  # post "/tasks", to: "tasks#create", as: "create_task"
  # patch "/tasks/:id/toggle_completed", to: "tasks#toggle_completed", as: "toggle_completed_task"
  # get "/tasks/:id/edit", to: "tasks#edit", as: "edit_task"
  # get "/tasks/:id", to: "tasks#show", as: "task"
  # patch "/tasks/:id", to: "tasks#update", as: "update_task"
  # delete "/tasks/:id", to: "tasks#destroy"
  resources :passengers

  root to: "drivers#index"
  resources :drivers

  root to: "trips#index"
  resource :trips

  root to: "homepages#index"
  resource :homepages
end

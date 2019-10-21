Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers
  resources :drivers
  resources :trips, only: [:show, :edit, :update, :destroy]

  resources :passengers, only: [:show] do
    resources :trips, only: [:create]
  end

  put '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'

  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  
  get "/auth/github", as: "github_login"
  #they contact us
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"
end
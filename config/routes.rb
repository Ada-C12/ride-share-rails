Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  
  
  resources :drivers

  resources :passengers do
    resources :trips, only: [:create]
  end
  
  resources :trips

  patch '/drivers/:id/toggle', to: 'drivers#toggle_active', as: 'toggle'
  get '/trips/:id/rating', to: 'trips#add_rating', as: 'add_rating'
  patch '/trips/:id/rating', to: 'trips#add_rating'
end

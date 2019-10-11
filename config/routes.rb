Rails.application.routes.draw do
  root to: 'pages#index'
  resources :trips, except: [:new]
  resources :drivers
  resources :passengers 
  resources :passengers do
    post :create_new_trip, on: :member
  end
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  
end

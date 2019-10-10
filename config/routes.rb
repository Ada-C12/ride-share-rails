Rails.application.routes.draw do
  root to: 'pages#index'
  resources :trips, except: [:new]
  resources :drivers
  resources :passengers 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :passengers do
    post :create_new_trip, on: :member
  end
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  
end

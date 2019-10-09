Rails.application.routes.draw do
  root to: 'pages#index'
  resources :trips
  resources :drivers
  resources :passengers 
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

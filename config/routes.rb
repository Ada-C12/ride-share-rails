Rails.application.routes.draw do
  root to: 'pages#index'
  resources :trips
  resources :drivers
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  
end

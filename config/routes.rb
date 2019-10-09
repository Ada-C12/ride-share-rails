Rails.application.routes.draw do
  root to: 'pages#index'
  resources :trips
  resources :drivers
<<<<<<< HEAD
  resources :passengers 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======
  patch '/drivers/:id/toggle_status', to: 'drivers#toggle_status', as: 'toggle_status_driver'
  
>>>>>>> origin/kristina
end

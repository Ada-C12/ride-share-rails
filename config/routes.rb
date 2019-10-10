Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  resources :homepages
  resources :drivers 
  resources :trips 
  resources :passengers do 
    resources :trips, shallow: true
  end
  patch "drivers/:id/activate", to: "drivers#toggle_activate", as: "activate"
  patch "drivers/:id/deactivate", to: "drivers#toggle_deactivate", as: "deactivate"
  
  
end

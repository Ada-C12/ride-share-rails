Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :homepages, only: [:index]
  
  patch '/drivers/:id/status/online', to: 'drivers#mark_online', as: 'mark_online'
  patch '/drivers/:id/status/offline', to: 'drivers#mark_offline', as: 'mark_offline'
  
  resources :drivers
  # patch '/drivers/:id/status', to: 'drivers#mark_online', as: 'mark_online'
  # patch '/drivers/:id/status', to: 'drivers#mark_offline', as: 'mark_offline'
  
  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :trips
end
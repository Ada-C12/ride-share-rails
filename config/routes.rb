Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  
  resources :passengers do
    resources :trips, only: [:index, :new, :create]
  end
  
  resources :drivers do
    resources :trips, only: :index
  end
  
  patch 'drivers/:id/toggle_active', to: 'drivers#toggle_active', as: 'toggle_active'
  
  
  resources :trips
  
  
end

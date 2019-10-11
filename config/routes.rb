Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'

  resources :drivers 

  resources :passengers do
    resources :trips, only: [:create]
  end
  
  resources :trips, except: [:index, :new]

  patch 'drivers/:id/make_active', to: 'drivers#make_active', as: 'make_active'
  patch 'drivers/:id/make_inactive', to: 'drivers#make_inactive', as: 'make_inactive'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'
  
  resources :passengers do
    resources :trips, only: [:index, :new]
  end
  
  resources :drivers do
    resources :trips, only: [:index, :new]
  end
  
  resources :trips
  
end

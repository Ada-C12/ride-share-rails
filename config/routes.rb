Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  
  resources :passengers do
    resources :trips, only: [:index, :create]
  end
  
  resources :drivers
  resources :trips, except: [:new]
end

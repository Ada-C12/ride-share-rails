Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # RESTful routes:
  root 'homepages#index'
  #root 'passengers#index'
  resources :drivers
  resources :passengers do
  resources :trips, only: [:create, :new]  
  end
end

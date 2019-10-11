Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # RESTful routes:
  root 'homepages#index'
  
  resources :drivers do
    resources :trips, only: [:new]
  end 
  
  resources :passengers do 
    resources :trips, only: [:create, :edit, :update, :show]
  end
  
  resources :trips
end 

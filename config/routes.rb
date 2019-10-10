Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # RESTful routes:
  root 'homepages#index'
  
  # this route works, but is not following rails conventions -- fix this... Make it nested.
  post 'passengers/:id/trips', to: 'trips#create', as: 'passenger_trips'
  
  #root 'passengers#index'
  resources :drivers
  resources :passengers do
    
  end
end

# 'author/:id', to: 'author#show', as: 'author'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # RESTful routes:
  root 'homepage#index'
  #root 'passengers#index'
  resources :drivers
  resources :passengers
  
  
  # 'author/:id', to: 'author#show', as: 'author'
end

Rails.application.routes.draw do
  get 'pages/index'
  root to: 'pages#home'
  resources :trips
  resources :drivers 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

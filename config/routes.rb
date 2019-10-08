Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homepages#index'


  resources :drivers, only: [:index, :show, :new, :create]

  resources :passengers, only: [:index, :show, :new, :create]

end

Rails.application.routes.draw do
  resources :passengers, except: [:update]
  patch '/passengers/:id', to: 'passengers#update'
  
  resources :drivers, except: [:update]
  patch '/drivers/:id', to: 'drivers#update'
  
  resources :tests, except: [:update, :index, :new, :create]
  patch '/tests/:id', to: 'tests#update'
  
end

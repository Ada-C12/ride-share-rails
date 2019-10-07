Rails.application.routes.draw do
  resources :passengers, #except: [:update]
  # patch '/passengers/:id', to: 'passengers#update', as:
  
end

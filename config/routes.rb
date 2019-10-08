Rails.application.routes.draw do
  # Set the homepage route    
  root 'homepages#index'
  resources :passengers

end

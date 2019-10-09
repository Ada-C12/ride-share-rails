Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :drivers 

  resources :passengers do 
    resources :trips, only: [:index, :new]
  end
  # add except: [:index, :new] since those actions not needed in app?
  resources :trips

end

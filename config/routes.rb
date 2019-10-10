Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  get "/homepages/nope", to: "homepages#nope", as: "nope"
  
<<<<<<< HEAD
  resources :drivers do 
    resources :trips, shallow: true
  end 
  
  resources :trips
=======
  resources :drivers
  resources :trips, except: [:new]
>>>>>>> 5163fd526bab365462ae91cbe955480ee3589176
  
  # ADDED THESE BELOW, to allow trip requests per passenger
  resources :passengers do 
    resources :trips, shallow: true
  end
  
end

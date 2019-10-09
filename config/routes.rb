Rails.application.routes.draw do

  root to: "homepages#index"

  resources :trips 
  resources :drivers do 
    resources :trips, shallow: true
  end

  resources :passengers do
    resources :trips, shallow:true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

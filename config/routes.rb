Rails.application.routes.draw do
  get 'homepages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  get "/homepages/nope", to: "homepages#nope", as: "nope"
  
  resources :drivers, :passengers, :trips
  
end

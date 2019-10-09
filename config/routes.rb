Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => "homepages#index"

  resources :passengers do
    resources :trips, only: [:index, :new] #do i want to add create? can use shallow: true. what about destroy? usually best practice not to have create without destroy because otherwise you can't delete what you've made...
  end

  resources :drivers do #only: [:index, :show, :new, :create, :edit] do
    resources :trips, only: [:index, :new, :create]
  end

  
  resources :homepages, only: [:index]
  resources :trips



end

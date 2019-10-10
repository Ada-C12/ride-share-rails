Rails.application.routes.draw do
  resources :passengers, except: [:update]
  patch '/passengers/:id', to: 'passengers#update'

  resources :drivers, except: [:update] do
    resources :trips, only: [:index]
  end
  patch '/drivers/:id', to: 'drivers#update'

  resources :trips, except: [:update, :index, :new]
  patch '/trips/:id', to: 'trips#update'
  get '/trips/:id/assign_rating/edit', to: 'trips#assign_rating_edit', as: 'assign_rating_edit'

  root 'homepages#index'
  get '/homepages', to: 'homepages#index', as: 'homepages'
end

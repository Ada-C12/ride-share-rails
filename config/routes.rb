Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'
  resources :passengers do
    resources :trips
  end
  
  resources :drivers
  resources :trips
  
  
  # post '/drivers/:id/active', to: 'drivers#active', as: 'active_driver'
  # resources :books #, except: [:index]
  
  
  # resources :authors, only: [:index, :show] do
  #   resources :books, only: [:index, :new]
  
  # NOTES FOR REFERENCE: 
  # RESTful Routes Include:
  # Rails.application.routes.draw do
  # get "/drivers" , to: "drivers#index", as: :driver
  # post "/books" , to: "books#create"
  # get "/books/new" , to: "books#new", as: :new_book
  # get "/books/:id" , to: "books#show", as: :book
  # patch "/books/:id" , to: "books#update"
  # put "/books/:id" , to: "books#update"
  # delete "/books/:id" , to: "books#destroy"
  # get "/books/:id/edit" , to: "books#edit", as: :edit_book
  # end
  
end



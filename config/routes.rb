Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :passengers
  resources :drivers
  resources :trips
  
  
  # NOTES FOR REFERENCE: 
  # RESTful Routes Include:
  # Rails.application.routes.draw do
  # get "/books" , to: "books#index", as: :book
  # post "/books" , to: "books#create"
  # get "/books/new" , to: "books#new", as: :new_book
  # get "/books/:id" , to: "books#show", as: :book
  # patch "/books/:id" , to: "books#update"
  # put "/books/:id" , to: "books#update"
  # delete "/books/:id" , to: "books#destroy"
  # get "/books/:id/edit" , to: "books#edit", as: :edit_book
  # end
end

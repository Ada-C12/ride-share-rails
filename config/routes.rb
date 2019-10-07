Rails.application.routes.draw do
  get    "/drivers"          , to: "drivers#index",   as: :drivers
  post   "/drivers"          , to: "drivers#create"
  get    "/drivers/new"      , to: "drivers#new",     as: :new_driver
  get    "/drivers/:id"      , to: "drivers#show",    as: :driver
  patch  "/drivers/:id"      , to: "drivers#update"
  delete "/drivers/:id"      , to: "drivers#destroy"
  get    "/drivers/:id/edit" , to: "drivers#edit",    as: :edit_driver
  
end

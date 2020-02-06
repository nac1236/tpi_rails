Rails.application.routes.draw do
   
  constraints(q: /[a-z]+_?[a-z]*/) do
    get 'products(/:q)', to: 'products#index'
  end

  jsonapi_resources :sessions, only: :create
  jsonapi_resources :users

  jsonapi_resources :products, except: [:index] do
    jsonapi_resources :items
  end

  jsonapi_resources :sells

  jsonapi_resources :details

  put 'reservations/:id/vender', to: 'reservations#update'

  jsonapi_resources :reservations, except: [:update]

  jsonapi_resources :cliente_dependientes, only: [:create,:index]

  jsonapi_resources :cliente_autonomos, only: [:create,:index]

end

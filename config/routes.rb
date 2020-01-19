Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  
  constraints(q: /[a-z]+_?[a-z]*/) do
    get 'products(/:q)', to: 'products#index'
  end

  jsonapi_resources :products, except: [:index] do
    jsonapi_resources :items
  end
end

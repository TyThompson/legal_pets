Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'
  resources :pets do
    collection { get :export }
    collection { post :import }
  end
  resources :charges
  get "/sell" => "pets#new"

  resources :users, only: [:show]
end

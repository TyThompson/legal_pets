Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'
  resources :pets, except: [:destroy, :new] do
    collection { get :export }
    collection { post :import }
  end
  resources :charges, only: [:create]
  resources :watchlists
  get "/sell" => "pets#new"
  get "/test" => "home#test"

  resources :users, only: [:show]
end

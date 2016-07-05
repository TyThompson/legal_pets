Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'
  resources :pets do
    collection { post :import }
  end
  resources :charges
  get "/sell" => "pets#new"

end

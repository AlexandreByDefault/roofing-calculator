Rails.application.routes.draw do
  # devise_for :users
  root to: 'pages#home'
  resources :buildings
  resources :flats, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  root "static_pages#home"

  get "/signup", to: "users#new"

  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    resources :books
  end

  resources :users, except: [:edit, :update, :destroy]

  resources :books, only: [:index, :show]
end

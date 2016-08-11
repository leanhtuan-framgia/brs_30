Rails.application.routes.draw do

  get "/signup", to: "users#new"

  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  namespace :admin do
    root "static_pages#home"
    resources :books
    resources :users, only: [:index, :destroy]
  end

  resources :users, except: [:edit, :update, :destroy]
  resources :books, only: [:index, :show]

  root "static_pages#home"

  resources :relationships, only: [:create, :destroy, :index]
end

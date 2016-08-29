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
    resources :categories, except: :show
    resources :requests, only: [:update, :edit, :index]
  end

  resources :reviews do
    resources :comments, except: [:index, :show, :new]
  end

  resources :books do
    resources :reviews, only: [:new, :create]
  end

  resources :users, except: [:edit, :update, :destroy]
  resources :books, only: [:index, :show]
  resources :requests, except: [:show, :update, :edit]
  resources :user_books, only: [:create, :update]
  resources :reviews, except: [:index, :create, :new]
  resources :likes, only: [:create, :destroy]
  root "static_pages#home"

  resources :relationships, only: [:create, :destroy, :index]
end

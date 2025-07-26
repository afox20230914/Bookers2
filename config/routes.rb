Rails.application.routes.draw do
  devise_for :users

  root to: "home#top"
  get "home/about", to: "home#about", as: "about"


    resources :post_images, only: [:new, :create, :index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  end
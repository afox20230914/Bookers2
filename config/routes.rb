Rails.application.routes.draw do
  scope "/bookers2" do
    devise_for :users
  
    root to: "homes#top"
    get "homes/about", to: "homes#about", as: "about"
  
    resources :post_images, only: [:new, :create, :index, :show, :destroy]
  
    resources :users, only: [:index, :show, :edit, :update]

    resources :books, only: [:new, :create, :index, :show, :destroy]
  end
end

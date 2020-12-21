Rails.application.routes.draw do
  devise_for :users
  root to: "photos#index"
  resources :photos do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  get '/photo/hashtag/:name', to: "photos#hashtag", as: :photo_hashtag
  get '/photo/category', to: "photos#category"

  resources :relationships, only: [:create, :destroy]
end
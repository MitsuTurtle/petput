Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root to: "photos#index"
  resources :photos do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: :show do
    member do
      get :following, :followers
    end
  end
  get '/photo/hashtag/:name', to: "photos#hashtag", as: :photo_hashtag
  get '/photo/category', to: "photos#category"

  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
end
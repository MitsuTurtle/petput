Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: "top#index"
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
      get :favorites
    end
  end
  get '/photo/hashtag/:name', to: "photos#hashtag", as: :photo_hashtag
  get '/photo/category', to: "photos#category"

  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create, :show]
  resources :notifications, only: [:index, :destroy]
end
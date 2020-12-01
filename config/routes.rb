Rails.application.routes.draw do
  devise_for :users
  root to: "photos#index"
  resources :photos, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: :create
  end
end
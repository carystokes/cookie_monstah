Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews, only: [:index, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy] do
    resources :votes
  end

  devise_for :views
  devise_for :users
end

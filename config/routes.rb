Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews, only: [:index, :create]
  end
  resources :reviews, only: [:edit, :update, :destroy] do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  devise_for :views
  devise_for :users
  
  resources :users
end

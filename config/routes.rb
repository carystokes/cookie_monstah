Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews
  end

  devise_for :views
  devise_for :users
  resources :users, only: [:index, :show]
end

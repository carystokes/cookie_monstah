Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews, only: [:index, :create, :update, :delete]
  end

  devise_for :views
  devise_for :users
end

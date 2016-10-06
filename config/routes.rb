Rails.application.routes.draw do
  root "recipes#index"

  resources :recipes do
    resources :reviews
  end

  resources :reviews do
    resources :votes 
  end

  devise_for :views
  devise_for :users
end

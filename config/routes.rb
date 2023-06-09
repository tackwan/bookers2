Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about" => 'homes#about', as: "about"
  resources :books
  resources :users, only: [:show, :edit, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: "followings"
    get 'followers' => 'relationships#followers', as: "followers"
  end
  get "search" => "searches#search"
end

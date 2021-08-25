Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :stores do
    resources :products, only: %i[new create]
    resources :reviews, only: %i[new create edit update index]
  end

  resources :reviews, only: [:destroy, :edit]
  resources :products, only: %i[index show edit update destroy]
  resources :carts, only: %i[show create edit update destroy]
  resources :cart_items, only: %i[create destroy update]
  resources :product_categories, only: %i[create destroy]
  resources :orders, only: %i[show index create update]
end

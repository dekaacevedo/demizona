Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions'}

  get 'my_stores', to: 'my_stores#index'

  get 'questions', to: 'infos#questions'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :stores do
    get :admin, on: :member
    resources :products, only: %i[new create]
    resources :reviews, only: %i[new create update edit destroy]
  end

  resources :products, only: %i[index show edit update destroy]
  resources :carts, only: %i[create edit update destroy]
    get 'cart', to: 'carts#show'
  resources :cart_items, only: %i[create destroy update]
  resources :product_categories, only: %i[create destroy]
  # resources :reviews, only: :destroy
  resources :orders, only: %i[show index create update]
  resources :categories, only: :show


end

Rails.application.routes.draw do
  namespace :admin do
      resources :accounts
      resources :buyers
      resources :carts
      resources :line_items
      resources :orders
      resources :products
      resources :sellers
      resources :super_accounts

      root to: "accounts#index"
    end
  devise_for :accounts, :controllers => { :registrations => 'registrations' }
  resources :orders
  mount ActionCable.server => '/cable'
  resources :carts
  resources :line_items
  root to: 'store#index', as: 'store_index'
  get 'store/index'
  get 'store/nocart'
  #get 'line_items/decrement'
  resources :line_items do
    member do
      patch "destroy"
    end
  end
  resources :products
  get 'search', to: 'store#search'
  resources :buyers, only: [:edit, :update]
  resources :sellers, only: [:edit, :update]
  resources :sellers do
    resources :products                                         # a nested route: seller_products_path

    member do
        get 'orders', to: 'line_items#show_orders_for_seller'   # a nested route: orders_seller_path
    end
  end
  resources :buyers do
    resources :orders                       # a nested route: buyer_orders_path
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

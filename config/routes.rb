Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  get 'carts/:id', to: 'carts#show', as: 'mycart'
  get 'search', to: 'store#search'

  resources :line_items do
    member do
      patch "decrement"
    end
   end

   mount ActionCable.server => '/cable'
   
  resources :products
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  end

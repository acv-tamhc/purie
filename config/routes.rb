Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  # match '/cart', to: 'cart#cart', :as => 'cart', via: :all
  # match '/cart/address', to: 'cart#address', :as => 'cart_address', via: :all
  # match '/cart/checkout', to: 'cart#checkout', :as => 'cart_checkout', via: :all
  resources :carts, path_names: { index: 'cart', new: 'address',  cart: 'checkout'}
  resources :categories
  resources :products
end

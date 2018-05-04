Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  resources :carts, path_names: { index: 'cart', new: 'address',  cart: 'checkout'}
  resources :categories
  resources :products
end

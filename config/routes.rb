Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  get 'products/:title', to: 'products#show'
  get 'all-products', to: 'categories#show'
  get 'product/:id', to: 'products#detail'
end

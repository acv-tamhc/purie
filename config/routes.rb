Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'
  root to: 'home#index'
  get 'product-info/:item_id', to: 'home#product_info'
  get 'products', to: 'home#products'
  get 'products/:title', to: 'products#show'
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  get 'products/:id', to: 'products#show', :as => 'product_detail'
  get 'all-products', to: 'categories#show'
end

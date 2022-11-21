Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'products#index'
  get 'customers/index'
  get 'customers/show'
  # get 'categories/index'
  # get 'categories/show'
  # get 'products/index'
  # get 'products/show'
  get 'orders/index'
  get 'orders/show'
  get 'product_details/index'
  get 'product_details/show'
  get 'provinces/index'
  get 'provinces/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :products, only: %i[index show] do
    collection do
      get 'search'
    end
  end

  resources :categories do
    collection do
      get 'search'
    end
  end
  # Defines the root path route ("/")
end

Rails.application.routes.draw do
  # devise_for :users do
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  # devise_for :users
  ActiveAdmin.routes(self)

  get 'customers/index'
  get 'customers/show'
  # get 'categories/index'
  # get 'categories/show'
  # get 'products/index'
  # get 'products/show'
  get 'orders/index'
  get 'orders/show'
  resources :orders, only: %i[index]
  get 'product_details/index'
  get 'product_details/show'
  get 'provinces/index'
  get 'provinces/show'

  get 'checkouts/invoice'
  get 'checkout', to: 'checkouts#show'
  get 'checkout/success', to: 'checkouts#success'
  get 'checkout/cancel', to: 'checkouts#cancel'

  get 'about/show'
  get 'billing', to: 'biling#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :products, only: %i[show] do
    collection do
      get 'search'
    end
  end

  resources :categories do
    collection do
      get 'search'
    end
  end

  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  # Defines the root path route ("/")
  root to: 'products#index'
end

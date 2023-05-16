Rails.application.routes.draw do
  root   "combos#index"
  get    "/signup",   to: "users#new" 
  get    "/login",    to: "sessions#new"
  post   "/login",    to: "sessions#create"
  delete "/logout",   to: "sessions#destroy"
  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :combos do
    resources :likes,    only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'post_ajax'
      get 'filter_ajax'
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users,               only: [:index, :show, :create, :update, :destroy]
      resources :sessions,            only: [:create, :destroy]
      resources :password_resets,     only: [:new, :create, :edit, :update]
      resources :account_activations, only: [:edit]
      resources :combos do
        resources :likes,    only: [:create, :destroy]
        resources :comments, only: [:create, :destroy]
      end
    end
  end
end

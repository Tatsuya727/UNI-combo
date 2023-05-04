Rails.application.routes.draw do
  root   "combos#index"
  get    "/signup",   to: "users#new" 
  get    "/login",    to: "sessions#new"
  post   "/login",    to: "sessions#create"
  delete "/logout",   to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :combos do
    collection do
      get 'post_ajax'
      get 'filter_ajax'
    end
  end
end

Rails.application.routes.draw do
  root "posts#index"
  get  "/signup", to: "users#new" 
  
end

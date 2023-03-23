Rails.application.routes.draw do
  get 'posts/home'
  root "application#hello"
end

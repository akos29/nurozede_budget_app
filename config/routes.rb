Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users
  resources :groups
  resources :expenses
  # Defines the root path route ("/")
  root "groups#index"
end

Rails.application.routes.draw do
  devise_for :users
  root 'products#new_copy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :users 
  resources :products
end
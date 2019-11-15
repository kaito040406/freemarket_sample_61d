Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'registrations'} #ロボットではない認証に使用
  root 'products#index'
  resources :products, only: [:show, :destroy, :create, :edit] do
    member do
      get 'buy'
      get 'my_details'
      get 'purchase_confirmation'
      get 'mypage'
      get 'update'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :products, only: [:new, :create, :edit, :destroy]
    namespace :api do
      resources :products, defaults: { format: 'json' } do
        collection do
          get 'child'
          get 'grand_child'
        end
      end
    end
    
    collection do
      get 'identification'
      get 'profile'
      get 'progress'
      get 'log_out'
    end
  end
  
  #ここから長谷川記入
  resources :signup do
    collection do
      get 'sign_in_select'
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5'
      get 'step6'
      get 'done'
    end
  end
  #ここまで長谷川記入

  resources :categories
  resources "users",only: [:index,:profile, :progress], path: 'mypage' do

    collection do
      get 'profile'
      get 'identification'
      get 'progress'
      get 'card'
    end
  end

  resources :credit_cards, only: [:index, :new, :show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      post 'show', to: 'cards#show'
    end
  end
end
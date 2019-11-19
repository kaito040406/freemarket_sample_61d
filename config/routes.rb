Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks'} #ロボットではない認証に使用
  root 'products#index'
  resources :products do
    member do
      get 'my_details'
      get 'purchase_confirmation'
      get 'done'
      get 'mypage'
      get 'buy'
      get 'tos'
      get 'failkure'
      get 'search'
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
          get 'number'
          get 'search'
        end
      end
    end
    
    collection do
      get 'identification'
      get 'profile'
      get 'progress'
      get 'log_out'
      get 'mypage'
      get 'privacy'
      get 'tos'
      get 'brand'
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
  resource :products, only: [:search]
  resources :categories, only: [:index, :show]
  
  resources "users",only: [:index,:profile, :progress, :cards], path: 'mypage' do

    collection do
      get 'profile'
      get 'identification'
      get 'progress'
      get 'cards'
      get 'credit'
      get 'tos'
      get 'brand'
    end
  end

  resources :cards, only: [:cards, :credit], path: '/mypage/cards' do
    collection do
      get 'cards'
      get 'credit'
    end
  end
  

  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      post 'show', to: 'cards#show'
    end
  end

end
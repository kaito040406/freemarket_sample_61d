Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'registrations'} #ロボットではない認証に使用
  root 'products#index'
  resources :products, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :products, only: [:new, :create, :edit, :destroy]
    

    collection do
      get 'identification'
      get 'profile'
      get 'progress'
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

  resources "users",only: [:index,:profile, :progress, :card], path: 'mypage' do
    collection do
      get 'profile'
      get 'identification'
      get 'progress'
      get 'my_details'
      get 'card'
    end
  end

  resources :cards, only: [:new, :show, :index] do
    collection do
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
      post 'show', to: 'cards#show'
    end
  end
end
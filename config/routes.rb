Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'registrations'} #ロボットではない認証に使用
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :products 
  end
  resources :categories
  resources :credit_cards, only: [:new, :create]
  #ここから長谷川記入
  resources :signup do
    collection do
      get 'sgin_in_select'
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

  resources "users",only: [:index,:profile], path: 'mypage' do
    collection do
      get 'profile'
      get 'identification'
    end
  end
end
Rails.application.routes.draw do
  devise_for :users,controllers: { registrations: 'registrations'} #ロボットではない認証に使用
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users 
  resources :products
  #ここから長谷川記入
  resources :signup do
    collection do
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
end
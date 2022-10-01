Rails.application.routes.draw do

  #会員用
  scope module: 'user' do
    devise_for :users,skip: [:passwords], controllers: {
      registrations: "users/registrations",
      sessions: 'users/sessions'
    }

    root to: "homes#top"
    get "about" => "homes#about"

    resources :users, only: [:create, :show, :edit, :update, :quit, :delete ] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    get '/users/mypage' =>'users#show'
    get '/users/infomation/edit' => 'users#edit'
    patch '/users/infomation' => 'users#update'
    get '/users/quit' => 'users#quit'
    patch '/users/close' => 'users#close'

    resources :posts, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
    resources :messages, :only => [:create, :destroy]
    resources :rooms, :only => [:create, :show, :index]

  end

  #管理者用

   devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admins/sessions'
    }

  namespace :admin do
    get "/" => "homes#top"

    resources :posts, only: [:index, :create, :show, :edit, :update, :destroy]
    resources :post_comments, only: [:create, :destroy ]
    resources :users, only: [:index, :show, :destroy]
    resources :admins, only: [:index, :create, :show, :edit, :update]
    
  end

end

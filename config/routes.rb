Rails.application.routes.draw do

  #会員用
  scope module: 'user' do
    devise_for :users,skip: [:passwords], controllers: {
      registrations: "user/registrations",
      sessions: 'user/sessions'
    }

    root to: "homes#top"
    get "about" => "homes#about"

    resources :users, only: [:create, :show, :edit, :update, :quit, :delete ] do
      member do
      get "favorites"
      end
      
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    get "search" => "searches#search"
    get "searches/search"
    get '/user/quit' => 'users#quit'
    patch '/user/delete' => 'users#delete'
    


    resources :posts, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:index, :create, :destroy]

    end

    resources :messages, :only => [:create, :destroy]
    resources :rooms, :only => [:create, :show, :index]

  end

  #管理者用

   devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: 'admin/sessions'
    }

  namespace :admin do
    get "/" => "homes#top"

    resources :posts, only: [:index, :show, :edit, :update, :destroy]
      resources :post_comments, only: [:destroy ]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

end

Rails.application.routes.draw do
# 会員用
# URL /users/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "users/registrations",
  sessions: 'users/sessions'
}

# 管理者用
# URL /admins/sign_in ...
devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admins/sessions"
}

end

class User::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]

  def top
  end

  def about
  end

  def guest
    user          = User.new(guest_user_params)
    user.name     = "ゲストユーザー"
    user.email    = SecureRandom.alphanumeric(15) + "@email.com"
    user.password = SecureRandom.alphanumeric(10)
    user.save
    sign_in user
    redirect_to posts_path
  end

  private
  
  def guest_user_params
    params.permit(:name, :email, :password)
  end

end

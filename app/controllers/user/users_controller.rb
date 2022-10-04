class User::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @post = Post.new
    @posts = Post.all
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ログイン完了です！"
      redirect_to user_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to admin_user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました！"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def quit
    @user = current_user
  end
  
  def delete
    @user = current_user
    @user.update(is_deleted: true)
    flash[:notice] = "これまでありがとうございました。また機会があればよろしくお願いします"
    sign_out
    redirect_to root_path
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end
  
  private
    def user_params
      params.require(:user).permit(:nickname, :introduction, :profile_image)
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end

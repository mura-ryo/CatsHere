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
      flash[:notice] = "Welcome! You have signed up successfully."
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
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def delete
    @user = current_user
    @user.update(is_deleted: true)
    sign_out
    redirect_to root_path
  end

  def quit
    @user = current_user
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

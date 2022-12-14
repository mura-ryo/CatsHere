class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # ユーザー更新時にパスワードの値が空だった場合、パスワードを更新しない
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました！"
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "更新に失敗しました！"
      redirect_to edit_admin_user_path(@user.id)
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
	def user_params
	  params.require(:user).permit(:name, :email, :is_deleted, :profile_image)
	end

end
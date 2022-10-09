class User::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ログイン完了です！"
      redirect_to user_path
    else
      render :new
    end
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

  # 退会機能
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

  # DM機能
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end
  
  def rooms
    @user = User.find(params[:id])
    @room = Room.find(params[:id])
    @rooms = Room.all
    @entries = @room.entries
    @users = User.all
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end

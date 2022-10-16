class User::UsersController < ApplicationController
  before_action :authenticate_user!

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
    # ユーザー更新時にパスワードの値が空だった場合、パスワードを更新しない
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if @user.update(user_params)
      # パスワード更新後、再ログイン
      sign_in(@user, :bypass => true)
      flash[:notice] = "更新に成功しました！"
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "更新に失敗しました！"
      redirect_to edit_user_path(@user.id)
    end
  end

  # 退会機能
  def quit
    @user = current_user
  end

  def delete
    @user = current_user
    @user.update(is_deleted: true)
    flash[:notice] = "ご利用いただきありがとうございました。またのご利用を心よりお待ちしております。"
    sign_out
    redirect_to root_path
  end

  # 会員情報
  def show
    @user = User.find(params[:id])
    @posts = @user.posts

  # チャット機能
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

  # いいね一覧機能
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :introduction, :profile_image)
    end

end

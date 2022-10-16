class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end


  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿が完了しました！"
      redirect_to posts_path(@post)
    else
      flash[:alert] = "投稿が失敗しました。タイトルと本文を記載してください。"
      redirect_to new_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @users = User.all
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました！"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "投稿の更新が失敗しました。タイトルと本文を記載してください。"
      redirect_to edit_post_path(@post.id)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # 投稿データのストロングパラメータ
  private
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
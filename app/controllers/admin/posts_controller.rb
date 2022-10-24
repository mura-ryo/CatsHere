class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @users = User.all
    @post_comments = @post.post_comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  # 投稿データのストロングパラメータ
  private
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
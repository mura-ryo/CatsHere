class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to posts_path(@post)
    else
      @user = current_user
      @posts = Post.all
      render :index
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
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
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
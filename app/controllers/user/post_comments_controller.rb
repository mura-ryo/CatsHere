class User::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @post_comments = @post.post_comments
    @comment.save
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end

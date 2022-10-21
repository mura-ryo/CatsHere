class Admin::PostCommentsController < ApplicationController

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments
  end


end
class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "ユーザー"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
    render "search_result"
  end
end

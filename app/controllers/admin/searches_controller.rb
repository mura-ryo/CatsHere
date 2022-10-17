class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "会員"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
    render "search_result"
  end
end

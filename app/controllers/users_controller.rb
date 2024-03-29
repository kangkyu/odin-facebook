class UsersController < ApplicationController
  
  def index
    @users = User.all.sort_by{|user| user.email}
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    @comment = Comment.new
  end
end

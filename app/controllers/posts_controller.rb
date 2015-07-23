class PostsController < ApplicationController

  # new might be unnecessary since index holds partial form
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash[:error] = "There was an error!"
      redirect_to posts_path
    end
  end

  def edit
  end

  def update
    #@post = Post.find(params[:id]).update_attribute
  end

  def index
    # show all recent posts from current user and friends
    @post = Post.new
    #temporary solution - inefficient query
    all_friend_ids = current_user.friend_ids + current_user.inverse_friend_ids
    @posts = Post.where("user_id IN (?) OR user_id = ?", all_friend_ids, current_user.id)
    # more efficient query - need to get results under one variable for it to work
    # friend_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id"
    # inverse_friend_ids = "SELECT user_id FROM friendships WHERE friend_id = :user_id"
    # # need to combine previous two lines somehow
    # all_friend_ids = friend_ids + inverse_friend_ids                     
    # @posts = Post.where("user_id IN (#{all_friend_ids}) OR user_id = :user_id",
    #                     user_id: current_user.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:content, :user_id)
    end

end


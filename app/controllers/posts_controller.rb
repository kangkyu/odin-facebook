class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post created!"
      redirect_to :back
    else
      flash[:danger] = @post.errors.full_messages.join
      redirect_to :back
    end
  end

  def edit
  end

  def update
  end

  def index
    @post = Post.new
    all_friend_ids = current_user.friend_ids + current_user.inverse_friend_ids
    @posts = Post.where("user_id IN (?) OR user_id = ?", all_friend_ids, current_user.id).order(created_at: :desc)
    @comment = Comment.new
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


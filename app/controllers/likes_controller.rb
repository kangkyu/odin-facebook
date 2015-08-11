class LikesController < ApplicationController
  
  def create
    @like = current_user.likes.create(like_params)
    @post = Post.find(@like.post_id)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    @post = Post.find(@like.post_id)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
    def like_params
      params.permit(:post_id, :user_id)
    end

end

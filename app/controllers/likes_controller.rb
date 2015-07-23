class LikesController < ApplicationController
  #ajax js not implemented yet
  
  def create
    @like = current_user.likes.create(like_params)
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  def destroy
    @like = Like.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  private
    def like_params
      params.permit(:post_id, :user_id)
    end

end

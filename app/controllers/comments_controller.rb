class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:id])
    @comment = current_user.comments.build(comments_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = "Comment created!"
      # need to fix redirect path
      redirect_to user_path(@user)
    else
      flash[:error] = "Error"
      redirect_to user_path(@user)
    end
  end

  private
    def comments_params
      params.require(:comment).permit(:user_id, :post_id, :comment)
    end
end

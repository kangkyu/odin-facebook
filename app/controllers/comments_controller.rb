class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comments_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to :back
    else
      flash[:danger] = @comment.errors.full_messages.join
      redirect_to :back
    end
  end

  private
    def comments_params
      params.require(:comment).permit(:user_id, :post_id, :comment)
    end
end

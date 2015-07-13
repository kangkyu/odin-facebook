class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friendship_params)

    if @friendship.save
      flash[:success] = "friend added!"
      redirect_to users_path
    else
      flash[:error] = "there was an error"
      redirect_to users_path
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:success] = "friend removed"
    redirect_to user_path
  end

  def show
    @my_requests = current_user.friendships.where(status: false)
    @pending_friends = current_user.inverse_friendships.where(status: false)
  end

  def update
    Friendship.find(params[:id]).update_attribute(:status, true)
    redirect_to user_path
  end

  private

    def friendship_params
      params.permit(:user_id, :friend_id, :status)
    end
end

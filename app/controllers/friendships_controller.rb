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
    redirect_to friendships_path
  end

  def show
    @my_requests = current_user.pending_friendships
    @pending_friends = current_user.pending_inverse_friendships
  end

  def update
    Friendship.find(params[:id]).update_attribute(:status, true)
    redirect_to users_path
  end

  def index
    @friendships = current_user.friendships + current_user.inverse_friendships
  end

  private

    def friendship_params
      params.permit(:user_id, :friend_id, :status)
    end
end

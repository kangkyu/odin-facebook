class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friendship_params)

    if @friendship.save
      flash[:success] = "Friend added!"
      redirect_to users_path
    else
      flash[:error] = @friendship.errors.full_messages.join
      redirect_to users_path
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:success] = "Friend removed!"
    redirect_to :back
  end

  def show
    @my_requests = current_user.pending_friendships
    @pending_requests = current_user.pending_inverse_friendships
    @pending_friends = current_user.pending_friends.sort_by { |friend| friend.email }
    @pending_inverse_friends = current_user.pending_inverse_friends.sort_by { |friend| friend.email }
  end

  def update
    Friendship.find(params[:id]).update_attribute(:status, true)
    flash[:success] = "Friend added!"
    redirect_to :back
  end

  def index
    @friendships = current_user.friendships + current_user.inverse_friendships
    @all_friends = (current_user.friends + current_user.inverse_friends).sort_by { |friend| friend.email }
  end

  private

    def friendship_params
      params.permit(:user_id, :friend_id, :status)
    end
end

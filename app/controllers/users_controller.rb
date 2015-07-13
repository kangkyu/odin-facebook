class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @active_friends = current_user.friendships.where(status: true)
    @passive_friends = current_user.inverse_friendships.where(status: true)
    @friendships = @active_friends + @passive_friends
  end
end

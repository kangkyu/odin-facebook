require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
 
  def setup
    @user = users(:conor)
    @friend = users(:dylan)
  end
 
  test "create friendship" do
   @user.friendships.create(friend_id: @friend.id, status: false )
   assert_equal(@user.friendships.count, 1)
  end

  test "destroy friendship" do
    @user.friendships.create(friend_id: @friend.id, status: true)
    assert_equal(@user.friendships.count, 1)
    @user.friendships.find_by(friend_id: @friend.id).destroy
    assert_equal(@user.friendships.count, 0)
  end
end

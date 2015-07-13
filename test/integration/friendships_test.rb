require 'test_helper'

class FriendshipsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:conor)
    @friend = users(:dylan)
  end

  test "build and accept friend request" do
    #friend request
    @user.friendships.build(friend_id: @friend.id, status: false).save
    assert_equal(@user.friendships.where(status: false).count, 1)

    #accept request
    assert_equal(@friend.inverse_friendships.where(user_id: @user.id).count, 1)
    @friend.inverse_friendships.find_by(user_id: @user.id).update_attribute(:status, true)

    #check both user and friend for existing friendship
    assert_equal(@user.friendships.first.friend.email, "dylan@fake.com")
    assert_equal(@friend.inverse_friendships.first.user.email, "conor@fake.com")
  end

  test "build and deny friend request" do
    #friend request
    @user.friendships.build(friend_id: @friend.id, status: false).save
    assert_equal(@user.friendships.where(status: false).count, 1)

    #deny request
    assert_equal(@friend.inverse_friendships.where(user_id: @user.id).count, 1)
    @friend.inverse_friendships.find_by(user_id: @user.id).destroy
    assert_equal(@friend.inverse_friendships.where(user_id: @user.id).count, 0)

    #check both user and friend for non-existing friendship
    assert_equal(@user.friendships.first, nil)
    assert_equal(@friend.inverse_friendships.first, nil)
  end



end

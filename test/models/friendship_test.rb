require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @user = users(:conor)
    @friend = users(:dylan)
    @friendship = Friendship.new(user_id: @user.id, friend_id: @friend.id, status: true)
  end

  test "create valid friendship" do
    assert @friendship.valid?
  end
 
  test "should have user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end

  test "should have friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end

  test "should have status" do
    @friendship.status = nil
    assert_not @friendship.valid?
  end

  test "cannot friend self" do
    @friendship.friend_id = @user.id
    assert_not @friendship.valid?
  end

  test "should be unique friendship even when user and friend are swapped" do
    @friendship.save
    friendship = Friendship.create(user_id: @friend.id, friend_id: @user.id, status: true)
    assert_not friendship.valid?
  end

  test "belongs to user" do
    friendship = @user.friendships.build(friend_id: @friend.id)
    assert friendship.valid?
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "foo@bar.com", password: "foobar123")
    @conor = users(:conor)
    @dylan = users(:dylan)
    @post = posts(:one)
  end

  test "create valid user" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = nil
    assert_not @user.valid?, "User not valid without email"
  end

  test "password should be present" do
    @user.password = nil
    assert_not @user.valid?, "User not valid without password"
  end

  # Association tests
  test "user has many posts" do
    post_count = @conor.posts.count
    @conor.posts.create(content: "this is conor")
    assert_equal @conor.posts.count, post_count + 1
  end

  test "user has many comments" do
    comment_count = @conor.comments.count
    @conor.comments.create(post_id: @post.id, comment: "my comment")
    assert_equal @conor.comments.count, comment_count + 1
  end

  test "user has many likes" do
    like_count = @conor.likes.count
    @conor.likes.create(post_id: @post.id)
    assert_equal @conor.likes.count, like_count + 1
  end

  test "user has many friendships and friends" do
    friendship = @conor.friendships.create(friend_id: @dylan.id)
    assert_equal @conor.friendships.last.friend_id, @dylan.id
    assert_equal @conor.friends.last, @dylan
  end

  test "user has many inverse friendships and inverse friends" do
    inverse_friendship = @conor.inverse_friendships.create(user_id: @dylan.id)
    assert_equal @conor.inverse_friendships.last.user_id, @dylan.id
    assert_equal @conor.inverse_friends.last, @dylan
  end

  test "user has many pending friendships and pending friends" do
    pending_friendship = @conor.pending_friendships.create(friend_id: @dylan.id)
    assert_equal @conor.pending_friendships.last.friend_id, @dylan.id
    assert_equal @conor.pending_friends.last.id, @dylan.id
  end

  test "user has many pending inverse friendships and pending inverse friends" do
    pending_inverse_friendship = @conor.pending_inverse_friendships.create(user_id: @dylan.id)
    assert_equal @conor.pending_inverse_friendships.last.user_id, @dylan.id
    assert_equal @conor.pending_inverse_friends.last.id, @dylan.id
  end

  test "destroys posts, comments, likes, friendships when user destroyed" do
    elliott = User.create(email: "elliott@email.com", password: "foobar123")
    post = elliott.posts.create(content: 'this is elliott')
    post.comments.create(user_id: elliott.id, comment: "this is elliott's comment")
    elliott.likes.create(post_id: post.id)
    elliott.friendships.create(friend_id: @conor.id, status: true)
    elliott.destroy
    assert_empty elliott.posts, "Posts should be empty after user destroyed"
    assert_empty elliott.comments, "Comments should be empty after user destroyed"
    assert_empty elliott.likes, "Likes should be empty after user destroyed"
    assert_empty elliott.friendships, "Friendships should be empty after user destroyed"
  end


end

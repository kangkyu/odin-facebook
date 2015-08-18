require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:conor)
    @post = Post.create(content: "content", user_id: @user.id)
  end

  test "create a valid post" do
    assert @post.valid?, 'Post requires content and user_id'
  end

  test "user_id should be present" do
    @post.user_id = nil
    assert_not @post.valid?, 'Post not valid when missing user_id'
  end

  test "content should be present" do
    @post.content = nil
    assert_not @post.valid?, 'Post not valid when missing content'
  end

  test "post belongs to user" do
    post = @user.posts.create(content: "Conor's post")
    assert post.valid?
  end
end

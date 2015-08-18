require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:conor)
    @post = posts(:one)
    @like = Like.new(user_id: @user.id, post_id: @post.id)
  end

  test "create valid like" do
    assert @like.valid?
  end

  test "user_id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "post_id should be present" do
    @like.post_id = nil
    assert_not @like.valid?
  end

  test "like should be unique" do
    count = Like.all.count
    @like.save
    @like.save
    assert_equal Like.all.count, count + 1
  end
end

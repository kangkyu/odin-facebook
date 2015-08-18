require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:conor)
    @post = posts(:one)
    @comment = Comment.new(user_id: @user.id, post_id: @post.id, comment: "This is a comment")
  end

  test "create valid comement" do
    assert @comment.valid?
  end

  test "should have user_id" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "should have post_id" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "should have comment" do
    @comment.comment = nil
    assert_not @comment.valid?
  end

  test "belongs to user" do
    comment = @user.comments.build(post_id: @post.id, 
                                   comment: "belongs to user")
    assert comment.valid?
  end

  test "belongs to post" do
    comment = @post.comments.build(user_id: @user.id, 
                                   comment: "belongs to post")
    assert comment.valid?
  end

end

require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:conor)
    @post = posts(:one)
    sign_in @user
    @request.env['HTTP_REFERER'] = '/posts'
  end

  test "should create a comment using valid parameters" do
    assert_difference('Comment.count') do
      post :create, comment: { comment: "hello" }, post_id: @post.id
    end
    assert_redirected_to '/posts'
  end

  test "should not create a comment using invalid parameters" do
    assert_no_difference('Comment.count') do
      post :create, comment: { comment: nil }, post_id: @post.id
    end
  end
end

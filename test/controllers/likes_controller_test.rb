require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @post = posts(:one)
    @user = users(:conor)
    sign_in @user
    @request.env['HTTP_REFERER'] = '/posts'
  end

  test "should create a like with valid parameters" do
    assert_difference('Like.count') do
       post :create, post_id: @post.id
    end
    assert_redirected_to '/posts'
  end

  test "should not create a like with invalid parameters" do
    sign_out @user
    assert_no_difference('Like.count') do
      post :create, like: { user_id: nil }, post_id: @post.id
    end
  end

  test "should destroy a like" do
    assert_difference('Like.count', -1) do
      delete :destroy, id: likes(:one).id
    end
  end
end

require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  def setup
    @post = posts(:one)
    sign_in users(:conor)
    @request.env['HTTP_REFERER'] = '/posts'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should create a post" do
    assert_difference('Post.count') do
      post :create, post: { content: "this is content" }
    end
    assert_redirected_to '/posts'
  end

  test "should not create post if missing content" do
    assert_no_difference('Post.count') do
      post :create, post: { content: nil }
    end
    assert_redirected_to '/posts'
  end
end

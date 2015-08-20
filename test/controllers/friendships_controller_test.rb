require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:conor)
    @friend = users(:dylan)
    @friendship = friendships(:one)
    sign_in @user
    @request.env['HTTP_REFERER'] = '/users'
  end

  test "should create a friendship with valid parameters" do
    assert_difference('Friendship.count') do
      post :create, friendship: { user_id: @user.id, status: true }, friend_id: @friend.id
    end
    assert_redirected_to '/users'
  end

  test "should not create a friendship with invalid parameters" do
    assert_no_difference('Friendship.count') do
      post :create, friendship: { user_id: nil }, friend_id: nil
    end
    assert_redirected_to '/users'
  end

  test "should destroy a friendship" do
    assert_difference('Friendship.count', -1) do
      delete :destroy, id: @friendship.id
    end
    assert_redirected_to '/users'
  end

  test "should get show" do
    get :show
    assert_response :success
    assert_not_nil assigns(:my_requests)
    assert_not_nil assigns(:pending_requests)
    assert_not_nil assigns(:pending_friends)
    assert_not_nil assigns(:pending_inverse_friends)
  end
  
  test "should update a friendship with valid parameters" do
    patch :update, id: @friendship, status: true
    assert_equal true, @friendship.reload.status
    assert_redirected_to '/users'
  end
  
  test "should not update a friendship with invalid parameters" do
    patch :update, id: @friendship, friendship: { user_id: nil }
    assert_equal 1, @friendship.reload.user_id
    assert_redirected_to '/users'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendships)
    assert_not_nil assigns(:all_friends)
  end
end

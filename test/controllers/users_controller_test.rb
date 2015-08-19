require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  def setup
    @user = users(:conor)
  end
  
  # Signed in
  test "should get index when signed in" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test "should get show when signed in" do
    sign_in @user
    get :show, id: @user.id 
    assert_response :success
  end

  # Signed out
  test "index should redirect to root when signed out" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "show should redirect to sign in page when signed out" do
    get :show, id: @user.id
    assert_redirected_to new_user_session_path
  end
end

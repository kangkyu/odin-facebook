require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  def setup
    @user = users(:conor)
    sign_in @user
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test "should get show" do
    get :show, id: @user.id 
    assert_response :success
  end
end

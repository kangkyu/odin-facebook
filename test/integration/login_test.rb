require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
   
  def setup
    @user = User.first
  end

  test "user login" do
    get new_user_session_path
    #assert_template ''
    post new_user_session_path, session: { email: @user.email, password: "foobar123" }
 #   assert user_signed_in?
   end
end

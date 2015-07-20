require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "feed should have the right posts" do
    conor = users(:conor)
    dylan = users(:dylan)
    rick = users(:rick)

    # posts from friend
    rick.posts.each do |post_friend|
      assert conor.feed.include?(post_friend)
    end

    # posts from self
    conor.posts.each do |post_self|
      assert conor.feed.include?(post_self)
    end

    # posts from non-friend
    dylan.posts.each do |post_nonfriend|
      assert_not conor.feed.include?(post_nonfriend)
    end 
  end
end

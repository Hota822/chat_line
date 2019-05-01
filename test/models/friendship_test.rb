require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @friendship = @user.friendships.build(friend_id: @other_user.id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end

end

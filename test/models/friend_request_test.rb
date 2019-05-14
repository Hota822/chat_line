require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @request_user = users(:archer)
    @friend_user = users(:lana)
    @non_friend = users(:malory)
    @one = friend_requests(:one)
    @one.request_user_id = @user.id
    @one.save
  end

  test "should be valid" do
    assert @one.valid?
  end

  test "should not be blank" do
    @one.user_id = nil
    assert_not @one.valid?
    setup
    @one.request_user_id = nil
    assert_not @one.valid?
  end

  test "user_relation should return valid information" do
    #user relation == friend
    assert_equal 'received_request', @user.user_relation(@request_user)
    assert_equal 'already_request',  @request_user.user_relation(@user)
    assert_equal 'current_user',     @user.user_relation(@user)
    assert_equal 'non_friend',       @user.user_relation(@non_friend)
  end

end

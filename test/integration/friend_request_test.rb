require 'test_helper'

class FriendRequestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @friend_user = users(:archer)
    @request_user = users(:lana)
    @non_friend_user = users(:malory)
    @user.friendships.create(friend_id: @friend_user.id)
    @user.friendships.create(request_id: @request_user.id)
    @request_user.friendships.create(request_id: @user.id)
  end

  test "any action need log in" do
  end


  test "user can check friend request list" do
    log_in_test(@user)
    get friendrequest_user_path(@user)
    assert_template 'friendships/new'
    assert_select 'h1', 'Friend requests'
    assert_select "a[href=?]", friendship_user_path(@request_user)
    assert_select "a[href=?]", friendship_user_path(@friend_user), count: 0
    assert_select "a[href=?]", friendship_user_path(@non_friend_user), count: 0
  end

  

end

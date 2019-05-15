require 'test_helper'

class FriendshipFunctionTest < ActionDispatch::IntegrationTest

  def setup
    set_instance_variables
    @request_user.friend_requests.create(request_user_id: @user.id)
    log_in_test(@user)
  end

  test "friendship should make when request is accepted" do
    get friendrequest_user_path(@user)
    assert_difference 'FriendRelation.count' do
      post friendrelation_user_path(@request_user), params:{ id: @request_user.id }
    end
    assert_equal 'friend', user_relation_test(@request_user)
    assert_redirected_to @request_user
    follow_redirect!
  end

  test "should reject request from invalid user" do
    get friendrequest_user_path(@user)
    assert_no_difference 'FriendRelation.count' do
      post friendrelation_user_path(@friend_user), params: { id: @friend_user.id }
      post friendrelation_user_path(@non_friend), params: { id: @non_friend.id }
    end
    assert_redirected_to root_path
    assert flash.any?
  end

  test "user have friend list" do
    add_friend_test(@user, @friend_user)
    get friendships_user_path(@user)
    assert_template 'users/index'
    assert_match  'Friend List', response.body
    assert_select "a[href=?]", user_path(@friend_user)
    assert_select "a[href=?]", user_path(@request_user), count: 0
    assert_select "a[href=?]", user_path(@non_friend), count: 0

  end

end

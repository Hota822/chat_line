require 'test_helper'

class FriendrequestFunctionTest < ActionDispatch::IntegrationTest
  def setup
    set_instance_variables
  end
  #・フレンド申請一覧
  #・フレンド申請の新規作成

  test "create new request with valid user" do
    log_in_test(@non_friend)
    get friendrequest_user_path(@user)
    assert_difference 'FriendRequest.count' do
      post friendrequest_user_path(@user), params: {id: @non_friend.id}
    end
    assert_redirected_to @user
    follow_redirect!
  end

  test "should not create request to myself" do
  end

  test "forbid new request with invalid user" do
  end



  test "show have friend request list" do
    log_in_test(@user)
    @request_user.friend_requests.create(request_user_id: @user.id)
    get friendrequest_user_path(@user)
    assert_template 'friend_requests/show'
    #assert_template partial: '_friend_request'
    assert_match  'Friend Request', response.body
    assert_select "a[href=?]", friendrelation_user_path(@request_user)
    assert_select "a[href=?]", friendrelation_user_path(@friend_user), count: 0
    assert_select "a[href=?]", friendrelation_user_path(@non_friend), count: 0
  end

end

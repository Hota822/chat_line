require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  def setup
    set_instance_variables
    @request_user.friend_requests.create(request_user_id: @user.id)
  end

  test "should get show (when logged in)" do
    get friendrequest_user_path(@user)
    follow_redirect!
    assert flash.any?
    log_in_test(@user)
    get friendrequest_user_path(@user)
    assert_response :success
  end

  test "post need log in" do
    post friendrequest_user_path(@user)
    follow_redirect!
    assert flash.any?
  end

end

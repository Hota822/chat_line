require 'test_helper'

class VeiwOfUserPageTest < ActionDispatch::IntegrationTest
  def setup
    set_instance_variables
    log_in_test(@user)
  end

  test "other user have each talk and group talks(already talken)" do
    @other_friend = users(:david)
    add_friend_test(@user, @friend_user)
    add_friend_test(@user, @other_friend)
    get user_path(@friend_user)
    assert_match '1 vs 1', response.body
    assert_match 'Group Talk', response.body
  end

  test "other user have each talk and group talks(no talk)" do
    add_friend_test(@user, @non_friend)
    get user_path(@non_friend)
    assert_match 'no 1vs1 talk', response.body
    assert_match 'no group talk', response.body
  end

  test "my-page have own all talks" do
    add_friend_test(@user, @friend_user)
    add_friend_test(@user, @other_friend)
    get user_path(@user)

end


require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'New User', email: 'new@example.com')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should not be blank" do
    @user.name = '     '
    assert_not @user.valid?
    setup
    @user.email = '      '
    assert_not @user.valid?
  end

  test "should not be too long" do
    @user.name = 'a' * 31
    assert_not @user.valid?
    setup
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end


end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'New User', email: 'new@example.com',
                      password: 'foobaraa', password_confirmation: 'foobaraa')
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

  test "email validation should accept valid email and reject invalid email" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
     valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
     end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com,user@example..com ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "name and email address should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email address shold be saved lower case" do
    mixed_address = 'Mixed@example.Com'
    @user.email = mixed_address
    @user.save
    assert_equal mixed_address.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test "password should have min length" do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end

end
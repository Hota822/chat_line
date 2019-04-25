require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information'do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '',
                                        email: 'invalid@mail',
                                        password: 'foo',
                                        password_confirmation: 'bar'}}
    end
    assert_template 'users/new'
    #assert_select 'div#css ID'
    #assert_select 'div.css class'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: { name: 'example user',
                                        email: 'example.com',
                                        password: 'password',
                                        password_confirmation: 'password'}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end

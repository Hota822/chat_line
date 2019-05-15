ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  #ユーザーがログイン中のときにTrueを返す
  def logged_in_test?
    !session[:user_id].nil?
  end

  #ログインする
  def log_in_test(user)
    session[:user_id] = user.id
    @login_user = user
  end

  def set_instance_variables
    @user = users(:michael)
    @request_user = users(:archer)
    @friend_user = users(:lana)
    @non_friend = users(:malory)
  end

  #ユーザー関係を返す
  def user_relation_test(user)
    @user_relation = @login_user.user_relation(user)
  end

  #フレンドに追加する
  def add_friend_test(user, other_user)
    other_user.friend_requests.create(request_user_id: user.id)
    user.add_friend(other_user)
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_test(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
    @login_user = user
  end
end
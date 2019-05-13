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
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_test(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end
end
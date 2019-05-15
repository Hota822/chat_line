require 'test_helper'

class LayoutsTestTest < ActionDispatch::IntegrationTest
  test "layout of home" do
    get root_path

  end

  test "layout of navigation bar" do
    get root_path
  end
end

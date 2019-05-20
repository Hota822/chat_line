require 'test_helper'

class TalkRoomsControllerTest < ActionDispatch::IntegrationTest

  def setup
  end

  test "should logged in before show" do
    @talk_room = talk_rooms(:vs)
    get talk_room_path(@talk_room)
    assert_redirected_to login_url
    assert flash.any?
  end
end

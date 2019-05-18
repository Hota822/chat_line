require 'test_helper'

class TalkroomFunctionTest < ActionDispatch::IntegrationTest

  def setup

  end

  test "talkroom_show have submenn, user_talk" do
    @talk_room = talk_rooms(:vs)
    get talk_room_path(@talk_room)
    assert_template 'talk_rooms/show'
    assert_select 'div.submenu', "Room : #{@talk_room.name}"
  end
end

require 'test_helper'

class TalkroomFunctionTest < ActionDispatch::IntegrationTest

  def setup
    set_instance_variables
    @talk_room = talk_rooms(:vs)
    @talk = talks(:talk_1)
  end

  test "talkroom_show have submenu, user_talk, new_message_form" do
    log_in_test(@user)
    #have submenu?
    @other_talk = talks(:talk_6)
    get talk_room_path(@talk_room)
    assert_template 'show'
    assert_select 'div.sub_menu', count: 3
    assert_match "Room : #{@talk_room.name}", response.body
    assert_select 'a[href=?]', invite_talk_room_path(@talk_room)
    assert_select 'a[href=?]', members_talk_room_path(@talk_room)
    #have user talk?
    assert_select 'div.list_contents div.icon'
    assert_select 'div.list_contents div.text'
    assert_match @talk.created_at.strftime("%m/%d %H:%M"), response.body
    assert_match @other_talk.created_at.strftime("%m/%d %H:%M"), response.body
    #have new message form?
    assert_select "input[value=#{@user.id}]"
    assert_select "input[value=#{@talk_room.id}]"
    assert_select "input[type=text]"
    assert_select "input[type=submit]"
  end

  test "show should valid user only" do
    log_in_test(@non_friend)
    get talk_room_path(@talk_room)
    assert_redirected_to root_url
    log_in_test(@request_user)
    get talk_room_path(@talk_room)
    assert_redirected_to root_url
    log_in_test(@friend_user)
    get talk_room_path(@talk_room)
    assert_template 'show'
  end

  test "invite should correct action" do
    log_in_test(@user)
    @other_friend = users(:david)
    add_friend_test(@user, @friend_user)
    add_friend_test(@user, @other_friend)
    get invite_talk_room_path(@talk_room)
    user_count = assigns(:friends).count
    assert @talk_room.users.count == 2
    assert_match 'Invite', response.body
    assert  user_count == 2
    assert_select 'input[type=checkbox]', count: user_count
    assert_select 'input[type=submit]'
    assert_no_difference 'UserTalkroomRelation.count' do
      post invite_talk_room_path(@talk_room), params: { friend: { "#{@friend_user.id}" => 'True' } }
      post invite_talk_room_path(@talk_room), params: { friend: { "#{@non_friend.id}" => 'True' } }
      assert_not flash[:alert].empty?
    end
    assert_difference 'UserTalkroomRelation.count' do
      post invite_talk_room_path(@talk_room), params: { friend: { "#{@other_friend.id}" => 'True' } }
    end
    assert_not flash[:success] == ""
    @talk_room.reload
    assert @talk_room.users.count == 3
    assert @talk_room.group_talk

  end

  test "send should create new message from valid user" do
    get talk_room_path(@talk_room)
    #not logged in
    assert_no_difference 'Talk.count' do
      post talks_path, params: { talk: { user_id: @user.id, talk_room_id: @talk_room.id, content: 'aaaaa' } }
    end
    log_in_test(@user)
    #valid user
    assert_difference 'Talk.count' do
      post talks_path, params: { talk: { user_id: @user.id, talk_room_id: @talk_room.id, content: 'aaaaa' } }
    end
    log_in_test(@non_friend)
    #not included talk room
    assert_no_difference 'Talk.count' do
      post talks_path, params: { talk: { user_id: @non_friend.id, talk_room_id: @talk_room.id, content: 'aaaaa' } }
    end
  end

  test "members have talk room members" do
    @talk_room = talk_rooms(:group)
    @other_friend = users(:david)
    log_in_test(@user)
    get members_talk_room_path(@talk_room)
    assert_match  @talk_room.name, response.body
    assert_select "a[href=?]", user_path(@friend_user)
    assert_select "a[href=?]", user_path(@other_friend)

  end

end

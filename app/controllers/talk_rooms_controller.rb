class TalkRoomsController < ApplicationController
  before_action :logged_in_user

  def show
    talk_room = TalkRoom.find(params[:id])
    @user = current_user
    @talks = talk_room.talks
    @new_talk = talk_room.talks.build()
  end

  def create
    debugger
    @user = User.find(params[:id])
    user_relation(@user)
    if @user_relation == 'friend'
      talk_room = TalkRoom.create()
      talk_room.invite(@user)
      talk_room.invite(current_user)
      redirect_to talk_room
    end
  end

  def new
    @friends = current_user.friendships
    @firend = current_user.friendships.first
  end

end

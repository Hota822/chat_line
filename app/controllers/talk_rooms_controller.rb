class TalkRoomsController < ApplicationController
  before_action :logged_in_user

  def show
    talk_room = TalkRoom.find(params[:id])
    @user = current_user
    @talks = talk_room.talks
    @new_talk = talk_room.talks.build()
  end

  def new
  end
end

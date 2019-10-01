class TalksController < ApplicationController
  before_action :logged_in_user

  def create
    talk = Talk.new(talk_params)
    if (params[:talk][:user_id] == "#{current_user.id}") && talk.talk_room.users.include?(current_user)
      talk.save
      talk.talk_room.touch
      redirect_to talk.talk_room
    else
      no_permission
    end
  end

  private

    def talk_params
      params.require(:talk).permit(:content, :user_id, :talk_room_id, :content_type)
    end
end

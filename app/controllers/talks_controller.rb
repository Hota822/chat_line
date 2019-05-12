class TalksController < ApplicationController

  def create
    talk = Talk.create(talk_params)
    redirect_to session[:forwarding_url]
  end

  private

    def talk_params
      params.require(:talk).permit(:content, :user_id, :talk_room_id)
    end
end

class UserTalkroomRelationsController < ApplicationController
  before_action :logged_in_user

  def new
    @friends = current_user.friendships
    @talk_room = TalkRoom.find(params[:id])
  end

  def create
    talk_room = TalkRoom.find(params[:id])
    if params[:friend].nil?
      flash[:alert] = 'Please selct'
      redirect_to talk_room
      return
    end
    friend_ids = current_user.friendship_ids
    invited_user = []
    friend_ids.each do |n|
      invited_user << n if params[:friend]["#{n}"]
    end
    invited_user.each do |n|
      #newの時点でも必要
      unless talk_room.user_ids.include?(n)
        user = User.find(n)
        talk_room.invite(user)
        flash[:success] += "  ・#{user.name}, "
      end
    end
    if flash.any?
      flash[:success] = "Add follow user:</br>" + flash[:success]
    else
      flash[:alert] = "Selected user has already joined this talk room"
    end
    redirect_to talk_room

  end

  def attempt
    render 'attemptings/attempt'
  end
end


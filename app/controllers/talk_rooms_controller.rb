class TalkRoomsController < ApplicationController
  before_action :logged_in_user

  def show
    @talk_room = TalkRoom.find(params[:id])
    @user = current_user
    if @talk_room.users.include?(@user)
      @talks = @talk_room.talks
      @new_talk = @talk_room.talks.build()
    else
      no_permission
    end
  end

  def create
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
    flash.now[:success] = 'please find user, and then stat to talk.<br>'
    flash.now[:success] += 'If you want to group talk, please invite after 1vs1 talk'
    render 'users/search'
  end

  def members
    @talk_room = TalkRoom.find(params[:id])
    @listusers = @talk_room.users
  end

  def attempt
    #instead of show
    @valtype = 's2'
    render 'attemptings/attempt'
  end

  def attemptpost
    @valtype = params[:valtype]
    @before_focus_id = params[:before_focus_id]
    print @before_focus_id
    respond_to do |format|
      format.html { redirect_to root_path}
      format.js { render 'attemptings/attempt'}
    end
  end
end

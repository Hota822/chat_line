# frozen_string_literal: true

# for talk rooms
class TalkRoomsController < ApplicationController
  before_action :logged_in_user

  def show
    @talk_room = TalkRoom.find(params[:id])
    @user = current_user
    if @talk_room.users.include?(@user)
      @talks = @talk_room.talks
      @new_talk = @talk_room.talks.build
    else
      no_permission
    end
  end

  def create
    @user = User.find(params[:id])
    user_relation(@user)
    return unless @user_relation == 'friend'

    talk_room = TalkRoom.create
    talk_room.invite(@user)
    talk_room.invite(current_user)
    redirect_to talk_room
  end

  def new
    flash.now[:success] = 'please find user, and then stat to talk.<br>'
    flash.now[:success] += 'If you want to group talk, '
    flash.now[:success] += 'please invite after 1vs1 talk'
    render 'users/search'
  end

  def edit
    @talk_room = TalkRoom.find(params[:id])
    @listusers = @talk_room.users
  end

  def update
    @talk_room = TalkRoom.find(params[:id])
    flash.now['success'] = 'Setting updated' if @talk_room.update_attributes(talk_room_params)
    render 'edit'
  end

  def attempt
    # instead of show
    @valtype = 's2'
    render 'attemptings/attempt'
  end

  def symbols
    @valtype = params[:valtype] # text_field
    @before_focused_id = params[:before_focused_id] # id of inserting when symbol is inserted
    @before_caret = params[:before_caret] # caret of inserting when symbol is inserted
    @count_index = params[:count_index].to_i # id counter to use inserting symbol
    commit = params['commit']
    case commit
    when 'Del'
      name_addition = '_del'
    when 'AC'
      name_addition = '_ac'
    else
      name_addition= ''
      @file_name, @transsymbol = commit_to_file(commit)
    end
    debugger
    respond_to do |format|
      format.html { redirect_to talk_room_path(params[:id]), flash: {alert: 'please activate javascript'}}
      format.js { render "talk_rooms/symbols#{name_addition}"}
    end
  end

  def calculate
    calculate_value = params[:calculate_value]
    # @return_value = eval(calculate_value)
    respond_to do |format|
      format.html { redirect_to talk_room_path(params[:id]), flash: {alert: 'please activate javascript'}}
      format.js { render 'talk_rooms/calculate'}
    end
  end

  # commit => to file=name
  def commit_to_file(value)
    html = '.html.erb'
    # return　'file-name', 'data_transsymbol(3) + inner_value_count(1)'
    case value
    when 'frc'
      return ('fraction' + html), 'frc2'
    when '∫'
      return ('integral' + html), 'igl3'
    when 'Σ'
      return ('sigma' + html), 'sgm3'
    else
    end
  end

  private
  
  def talk_room_params()
    params.require(:talk_rooms).permit(:name)
  end
end

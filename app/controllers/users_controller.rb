class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :search, :result, :index]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    user_relation(@user)
    case @user_relation
    when 'friend'
      each_talk_room_ids =[]
      own_talk_rooms = current_user.talk_room_ids
      friend_talk_rooms = @user.talk_room_ids
      own_talk_rooms.each do |n|
        if friend_talk_rooms.include?(n)
           each_talk_room_ids << n
        end
      end
      unless each_talk_room_ids.nil?
        @talk_rooms = TalkRoom.where("id IN (?)", each_talk_room_ids)
        @each_talk_room = @talk_rooms.where("group_talk = false")
        @talk_rooms = @talk_rooms.where("group_talk = true")
      end
    when 'current_user'
      @talk_rooms = current_user.talk_rooms.order(updated_at: :desc)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Account Created!'
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def search
  end

  def result
    @user = User.find_by(name: params[:name])
    if @user
      redirect_to @user
    else
      flash[:alert] = 'User not found. Please check a spelling'
      redirect_to search_users_url
    end
  end

  def index
    @listusers = current_user.friendships
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

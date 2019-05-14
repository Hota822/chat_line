class FriendshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user_to = current_user
    @user_from = User.find(params[:id])
    @user_to_request = Friendship.find_by(user_id: @user_from.id, request_id: @user_to.id)
    @user_to_request.friend_id = @user_from.id
    @user_to_request.request_id = nil
    @user_to_request.save
    @user_from.friendships.create(friend_id: @user_to.id)
    redirect_to friendship_user_path(@user_to)
  end

  def index
    @friends = current_user.friend_list
    render 'friendlist'
  end

end

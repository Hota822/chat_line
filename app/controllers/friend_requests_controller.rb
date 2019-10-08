# frozen_string_literal: true

# for friend request from user
class FriendRequestsController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find(params[:id])
    # @friend_request = @user.friend_request
    user_relation(@user)
  end

  def create
    user_to = User.find(params[:id])
    user_relation(user_to)
    if @user_relation == 'non_friend'
      current_user.friend_requests.create(request_user_id: user_to.id)
      redirect_to user_to
    else
      redirect_to root_url
    end
  end
end

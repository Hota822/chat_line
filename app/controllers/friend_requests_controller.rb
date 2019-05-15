class FriendRequestsController < ApplicationController
  before_action :logged_in_user

  def show
    @user = User.find(params[:id])
    #@friend_request = @user.friend_request
    user_relation(@user)
  end

  def create
    user_to = User.find(params[:id])
    user_relation(user_to)
    unless @user_relation == 'non_friend'
      redirect_to root_url
    else
      current_user.friend_requests.create(request_user_id: user_to.id)
      redirect_to user_to
    end
  end
end

# frozen_string_literal: true

# for mid table user-user
class FriendRelationsController < ApplicationController
  before_action :logged_in_user
  # before_action ->{ permitted_user?('recieved_request') }
  before_action :request_user

  def create
    @user_to = current_user
    @user_from = User.find(params[:id])
    @user_to.add_friend(@user_from)
    flash.now[:success] = "#{@user_from.name} become your friends!"
    redirect_to friendrequest_user_path(@user_to)
  end

  private

  def request_user
    user_relation(User.find(params[:id]))
    return if @user_relation == 'received_request'

    flash.now[:alert] = 'Not Permitted'
    redirect_to root_url
  end
end

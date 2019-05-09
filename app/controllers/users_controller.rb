class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

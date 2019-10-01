class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "Please log in."
      redirect_to login_url
    end
  end

  def no_permission
    flash[:alert] = 'you dont have permission'
    redirect_to root_url
  end

  private
    def user_relation(user)
      @user_relation = current_user.user_relation(user)
    end

    #def permitted_user?(permitted_relation)
      #@user_relation.include?(permitted_relation)
    #end
end

module SessionsHelper

  #渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  #渡されたユーザーがログイン済みのユーザーのときTrueを返す
  def current_user?(user)
    user == current_user
  end

  #ユーザーが存在するとき、ログイン中のユーザーを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  #ユーザーがログインしていたときにTrue、それ以外はFalseを返す
  def logged_in?
    !current_user.nil?
  end

  #ログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil?
  end

end

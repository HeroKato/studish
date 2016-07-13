module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:coach_id] = @coach.id
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_coach)
    session[:coach_id] = nil
    @current_coach = nil
  end
  
  # 記憶トークンcookieに対応するユーザーを返す
  def current_coach
    if (coach_id = session[:coach_id])
      @current_coach ||= Coach.find_by(id: coach_id)
    elsif (coach_id = cookies.signed[:coach_id])
      coach = Coach.find_by(id: coach_id)
      if coach && coach.authenticated?(cookies[:remember_token])
        log_in coach
        @current_coach = coach
      end
    end
  end
  
   # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !!current_coach
  end
  
  #ユーザーを永続的セッションに記憶する
  def remember(coach)
    coach.remember
    cookies.permanent.signed[:coach_id] = @coach.id
    cookies.permanent[:remember_token] = @coach.remember_token
  end
  
  # 永続的セッションを破棄する
  def forget(coach)
    coach.forget
    cookies.delete(:coach_id)
    cookies.delete(:remember_token)
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  # 与えられたユーザー（講師）がログイン済みユーザーであればtrueを返す
  def current_coach?(coach)
    coach == current_coach
  end
end

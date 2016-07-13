module SessionsHelper
  # 講師としてログインする
  def log_in(user)
    session[:coach_id] = @coach.id
  end
  
  def log_out
    forget(current_coach)
    session[:coach_id] = nil
    @current_coach = nil
  end
  
  # 現在の講師
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
  
  # ログインしているかどうか確認
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
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  # 与えられたユーザー（講師）がログイン済みユーザーであればtrueを返す
  def current_coach?(coach)
    coach == current_coach
  end
end

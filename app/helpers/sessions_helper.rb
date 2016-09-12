module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    if user.model_name.name == "Coach"
      session[:coach_id] = user.id
    else
      session[:student_id] = user.id
    end
    #ここのsessionはRailsで定義済みのメソッドでsessions_controllerとは無関係
    #session[:coach_id] = coach.id
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    if current_coach
      forget(current_coach)
      session[:coach_id] = nil
      @current_coach = nil
    else
      forget(current_student)
      session[:student_id] = nil
      @current_student = nil
    end
    #forget(current_coach)
    #session[:coach_id] = nil
    #@current_coach = nil
  end
  
  # 現在ログイン中のコーチを返す（いる場合）
  def current_coach
    if (coach_id = session[:coach_id])
      @current_coach ||= Coach.find_by(id: coach_id)
    elsif (coach_id = cookies.signed[:coach_id])
      coach = Coach.find_by(id: coach_id)
      if coach && coach.authenticated?(:remember, cookies[:remember_token])
        log_in coach
        @current_coach = coach
      end
    end
  end
  
  # 現在ログイン中の生徒を返す（いる場合）
  def current_student
    if (student_id = session[:student_id])
      @current_student ||= Student.find_by(id: student_id)
    elsif (student_id = cookies.signed[:student_id])
      student = Student.find_by(id: student_id)
      if student && student.authenticated?(:remember, cookies[:remember_token])
        log_in student
        @current_student = student
      end
    end
  end
  
   # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in_as_coach?
    !!current_coach
  end
  
  def logged_in_as_student?
    !!current_student
  end
  
  #ユーザーを永続的セッションに記憶する
  def remember(coach)
    coach.remember
    cookies.permanent.signed[:coach_id] = coach.id
    cookies.permanent[:remember_token] = coach.remember_token
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    if user.model_name.name == "Coach"
      user.forget
      cookies.delete(:coach_id)
    else
      user.forget
      cookies.delete(:student_id)
    end
    cookies.delete(:remember_token)
  end
  #def forget(coach)
  #  coach.forget
  #  cookies.delete(:coach_id)
  #  cookies.delete(:remember_token)
  #end
  
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
  
  def current_student?(student)
    student == current_student
  end
end

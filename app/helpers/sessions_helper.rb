module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    #ここのsessionはRailsで定義済みのメソッドでsessions_controllerとは無関係
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    if current_user
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end
  end
  
  # 現在ログイン中のコーチ@coachを返す（いる場合）
  #def current_coach
  #  if (coach_id = session[:coach_id])
  #    @current_coach ||= Coach.find_by(id: coach_id)
  #  elsif (coach_id = cookies.signed[:coach_id])
  #    coach = Coach.find_by(id: coach_id)
  #    if coach && coach.authenticated?(:remember, cookies[:remember_token])
  #      log_in coach
  #      @current_coach = coach
  #    end
  #  end
  #end
  
  # 現在ログイン中の生徒を返す（いる場合）
  #def current_student
  #  if (student_id = session[:student_id])
  #    @current_student ||= Student.find_by(id: student_id)
  #  elsif (student_id = cookies.signed[:student_id])
  #    student = Student.find_by(id: student_id)
  #    if student && student.authenticated?(:remember, cookies[:remember_token])
  #      log_in student
  #     @current_student = student
  #    end
  #  end
  #end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # 現在ログイン中のuserがいればそのuserを返す（記憶トークンcookieに対応するユーザーを返す）
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # 現在のコーチとしてログインしていればtrue、その他ならfalseを返す
  #def logged_in_as_coach?
  #  !!current_coach
  #end
  
  #def logged_in_as_student?
  #  !!current_student
  #end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  
  #ユーザーを永続的セッションに記憶する
  #def remember(coach)
  #  coach.remember
  #  cookies.permanent.signed[:coach_id] = coach.id
  #  cookies.permanent[:remember_token] = coach.remember_token
  #end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
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
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  # 与えられたユーザー（講師）がログイン済みユーザーであればtrueを返す
  #def current_coach?(coach)
  #  coach == current_coach
  #end
  
  #def current_student?(student)
  #  student == current_student
  #end

end

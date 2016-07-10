module SessionsHelper
  def current_coach
    @current_coach ||= Coach.find_by(id: session[:coach_id])
  end
  
  def logged_in?
    !!current_coach
  end
  
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  # 与えられたユーザー（講師）がログイン済みユーザーであればtrueを返す
  def current_coach?(coach)
    coach == current_coach
  end
end

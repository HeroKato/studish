class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # before_action :basic_auth if Rails.env.staging?
  before_action :set_notifications_count
  
  private
  
  # ログインしている講師かどうか確認
  def logged_in_coach
    unless logged_in_as_coach?
      store_location
      flash[:denger] = "Please log-in as coach."
      redirect_to login_url
    end
  end
  
  def logged_in_student
    unless logged_in_as_student?
      store_location
      flash[:danger] = "Please log-in as student."
      redirect_to login_url
    end
  end
  
  def logged_in_user
    if logged_in_as_student?
    elsif logged_in_as_coach?
    else
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end
  
  # 正しいユーザーかどうか確認
  def correct_coach
    if controller_name == "notifications"
      @coach = Coach.find(params[:format])
    else
      @coach = Coach.find(params[:coach_id])
    end
    unless current_coach?(@coach)
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end
  
  def correct_student
    student = Student.find_by(params[:student_id])
    unless current_student?(student)
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end
  
  def correct_user
    @student = Student.find_by(params[:student_id])
    if current_student?(@student)
    else
      @coach = Coach.find_by(params[:coach_id])
      unless current_coach?(@coach)
        flash[:danger] = "Please log in as correct user."
        redirect_to(login_url)
      end
    end
  end
  
  def correct_user_2
    user = User.find_by(params[:user_id])
    unless current_user?(user)
      flash[:danger] = "Please log in as correct user."
      redirect_to(login_url)
    end
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |coach, pass|
      coach == ENV['BASIC_AUTH_ADMINNAME'] && pass == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  
  def set_notifications_count
    if logged_in_as_student?
      current_student_id = current_student.id
      @not_read_post_comments = PostComment.where(commented_student_id: current_student_id, check_flag: false).count
      @not_checked_favorites = Favorite.where(favorited_student_id: current_student_id, check_flag: false).count
      @notifications_count = @not_read_post_comments+@not_checked_favorites
    elsif logged_in_as_coach?
      current_coach_id = current_coach.id
      @not_read_post_comments = PostComment.where(commented_coach_id: current_coach_id, check_flag: false).count
      @not_checked_favorites = Favorite.where(favorited_coach_id: current_coach_id, check_flag: false).count
      @notifications_count = @not_read_post_comments+@not_checked_favorites
    end
  end
  
  def save_flags
    if @notifications.present?
      @notifications.each do |n|
        if n["read_flag"] == false
          n["read_flag"] = true
          n.save
        end
        if n["check_flag"] == false
          n["check_flag"] = true
          n.save
        end
      end
    end
  end
  
  def student?
    if params[:student_id]
    else
      return false
    end
  end
  
  def favorited?(coach)
    favorites.where(coach_id: coach.id).exists?
  end

end

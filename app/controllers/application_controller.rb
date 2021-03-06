class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # before_action :basic_auth if Rails.env.staging?
  before_action :set_notifications_count
  before_action :set_default_meta
  
  private
  
  def set_default_meta
    @description = "Studishはオンライン個別指導サービスです。科目指導＋コーチングで中高生の学習を強力にサポートします。"
    @keywords = "Studish,スタディッシュ,オンライン指導,コーチング,Coaching,自学スキル向上,大学受験,高校受験"
    @creator = "@hirotutor"
    @twitter_image_url = "http://studish-stg.herokuapp.com/assets/twitter-card_top-be87008045ec07d9caba31566b10532a9cf58d02159124fa6467c2a7b06bd53e.png"
  end
  
  # ログインしている講師かどうか確認
  #def logged_in_coach
  #  unless logged_in_as_coach?
  #    store_location
  #    flash[:denger] = "Please log-in as coach."
  #    redirect_to login_url
  #  end
  #end
  
  #def logged_in_student
  #  unless logged_in_as_student?
  #    store_location
  #    flash[:danger] = "Please log-in as student."
  #    redirect_to login_url
  #  end
  #end
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # 正しいユーザーかどうか確認
  #def correct_coach
  #  if controller_name == "notifications"
  #    @coach = Coach.find(params[:format])
  #  else
  #    @coach = Coach.find(params[:coach_id])
  #  end
  #  unless current_coach?(@coach)
  #    flash[:danger] = "Please log in as correct user."
  #    redirect_to(login_url)
  #  end
  #end
  
  #def correct_student
  #  student = Student.find_by(params[:student_id])
  #  unless current_student?(student)
  #    flash[:danger] = "Please log in as correct user."
  #    redirect_to(login_url)
  #  end
  #end
  
  #def correct_user
  #  @student = Student.find_by(params[:student_id])
  #  if current_student?(@student)
  #  else
  #    @coach = Coach.find_by(params[:coach_id])
  #    unless current_coach?(@coach)
  #      flash[:danger] = "Please log in as correct user."
  #      redirect_to(login_url)
  #    end
  #  end
  #end
  
  #def correct_user
  #  user = User.find_by(params[:user_id])
  #  unless current_user?(user)
  #   flash[:danger] = "Please log in as correct user."
  #    redirect_to(login_url)
  #  end
  #end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |coach, pass|
      coach == ENV['BASIC_AUTH_ADMINNAME'] && pass == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  
  def set_notifications_count
    if logged_in?
      current_user_id = current_user.id
      @not_read_post_comments = PostComment.where(commented_user_id: current_user_id, check_flag: false).count
      @not_checked_favorites = Favorite.where(favorited_user_id: current_user_id, check_flag: false).count
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

end

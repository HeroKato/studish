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
    unless logged_in?
      store_location
      flash[:denger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # 正しいユーザーかどうか確認
  def correct_coach
    @coach = Coach.find(params[:id])
    unless current_coach?(@coach)
      redirect_to(login_url)
      flash[:danger] = "Please log in as correct user."
    end
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |coach, pass|
      coach == ENV['BASIC_AUTH_ADMINNAME'] && pass == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  
  def set_notifications_count
    if logged_in?
      current_coach_id = current_coach.id
      @not_read_comments = Comment.where(commented_coach_id: current_coach_id, read_flag: false).count
      @not_checked_favorites = Favorite.where(favorited_coach_id: current_coach_id, check_flag: false).count
      @notificaitions_count = @not_read_comments+@not_checked_favorites
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

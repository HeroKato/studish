class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :basic_auth if Rails.env.staging?
  before_action :set_not_read_count
  
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
  
  def set_not_read_count
    if logged_in?
      current_coach_id = current_coach.id
      @not_read_count = Comment.where(commented_coach_id: current_coach_id, read_flag: false).count
    end
  end
  
  def save_read_flag
    if @comments.present?
      @comments.each do |comment|
        comment.read_flag = true
        comment.save
      end
    end
  end
  
end

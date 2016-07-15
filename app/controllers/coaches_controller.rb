class CoachesController < ApplicationController
  before_action :logged_in_coach, only: [:edit, :update, :destroy]
  before_action :correct_coach, only:[:edit, :update, :destroy]
  
  def index
    @coaches = Coach.order("id")
  end
  
  def show
    @coach = Coach.find(params[:id])
  end
  
  def new
    unless logged_in?
      @coach = Coach.new(birthday: Date.new(1997, 1, 1))
    else
      flash[:danger] = "Please log out before creating a new coach account."
      redirect_to root_path
    end
  end
  
  def edit
    @coach = Coach.find(params[:id])
  end
  
  def create
    @coach = Coach.new(coach_params)
    if @coach.save
      log_in @coach
      flash[:success] = "Welcome to Studish! Resistration Success!"
      redirect_to @coach
    else
      render "new"
    end
  end
  
  def update
    @coach = Coach.find(params[:id])
    @coach.assign_attributes(coach_params)
    if @coach.save
      flash[:success] = "Profile Edit Success!"
      redirect_to @coach
    else
      render "edit"
    end
  end
  
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy
    flash[:success] = "Deleted Your Account."
    redirect_to :coaches
  end
  
  private
  
  def coach_params
    attrs = [:name, :full_name, :email, :birthday,
              :university, :major, :school_year, :subject,
              :self_introduction, :administrator,
              :password, :password_confirmation, :picture]
    params.require(:coach).permit(attrs)
  end
  
  
  # 正しいユーザーかどうか確認
  def correct_coach
    @coach = Coach.find(params[:id])
    unless current_coach?(@coach)
      flash[:danger] = "Please log in correct coach."
      redirect_to(root_url)
    end
  end
  
  # ログイン済みユーザーかどうか確認
  def logged_in_coach
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
end

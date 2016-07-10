class CoachesController < ApplicationController
  before_action :logged_in_coach, only: [:edit, :update, :destroy]
  before_action :correct_coach, only:[:edit, :update, :destroy]
  
  def index
    @coaches = Coach.order("id")
  end
  
  def show
    @coach = Coach.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      render "show"
    end
  end
  
  def new
    @coach = Coach.new(birthday: Date.new(1997, 1, 1))
    @coach.build_image
  end
  
  def edit
    @coach = Coach.find(params[:id])
    @coach.build_image unless @coach.image
  end
  
  def create
    @coach = Coach.new(coach_params)
    if @coach.save
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
      redirect_to @coach, notice: "プロフィールを更新しました！"
    else
      render "edit"
    end
  end
  
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy
    redirect_to :coaches, notice: "アカウントを削除しました。"
  end
  
  private
  
  def coach_params
    attrs = [:name, :full_name, :email, :birthday,
              :university, :major, :school_year, :subject,
              :self_introduction, :administrator,
              :password, :password_confirmation]
    attrs << { image_attributes: [:_destroy, :id, :uploaded_image] }
    params.require(:coach).permit(attrs)
  end
  
  def send_image
    if @coach.image.present?
      send_data @coach.image.data,
        type: @coach.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
  
end

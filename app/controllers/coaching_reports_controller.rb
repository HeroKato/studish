class CoachingReportsController < ApplicationController
  before_action :logged_in?
  
  def index
    if params[:coach_id]
      @coach = Coach.find(params[:coach_id])
      @reports = @coach.coaching_reports
      @reports = @reports.readable_for(current_coach).order(posted_at: :desc).paginate(page: params[:page], per_page: 30)
    else
      @reports = CoachingReport.all
      @reports = @reports.common.order(posted_at: :desc).paginate(page: params[:page], per_page: 30)
    end
  end

  def show
    @report = CoachingReport.readable_for(current_coach).find(params[:id])
  end

  def new
    @report = CoachingReport.new(posted_at: Time.current)
  end

  def edit
    @report = current_coach.coaching_reports.find(params[:id])
  end
  
  def create
    @report = CoachingReport.new(report_params)
    @report.author = current_coach
    if @report.save
      flash[:success] = "レポートを作成しました!"
      redirect_to @report
    else
      render 'new'
    end
  end
  
  def update
    @report = current_coach.coaching_reports.find(params[:id])
    @report.assign_attributes(report_params)
    if @report.save
      flash[:success] = "レポートを更新しました。"
      redirect_to @report
    else
      render 'edit'
    end
  end
  
  def destroy
    @report = current_coach.coaching_reports.find(params[:id])
    @report.destroy
    flash[:success] = "レポートを削除しました。"
    redirect_to :coaching_reports
  end
  
  private
  
  def report_params
    params.require(:coaching_report).permit(:title, :body, :posted_at, :status)
  end
end

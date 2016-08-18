class CoachingReportsController < ApplicationController
  before_action :logged_in?
  
  def index
    if params[:coach_id]
      @coach = Coach.find(params[:coach_id])
      @reports = @coach.coaching_reports
    else
      @reports = CoachingReport.all
    end
    @reports = @reports.common.order(posted_at: :desc).paginate(page: params[:page], per_page: 30)
  end

  def show
    @report = CoachingReport.common.find(params[:id])
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
      redirect_to @report, notice: "レポートを作成しました。"
    else
      render 'new'
    end
  end
  
  def update
    @report = current_coach.coaching_reports.find(params[:id])
    @report.assign_attributes(report_params)
    if @report.save
      redirect_to @report, notice: "レポートを更新しました。"
    else
      render 'edit'
    end
  end
  
  def destroy
    @report = current_coach.coaching_reports.find(params[:id])
    @report.destroy
    redirect_to :coaching_reports, notice: "レポートを削除しました。"
  end
  
  private
  
  def report_params
    params.require(:coaching_report).permit(:title, :body, :posted_at, :status)
  end
end

class CoachingReportsController < ApplicationController
  before_action :logged_in_as_coach?
  after_action :save_flags, only: [:show]
  before_action :full_profile, only: [:new]
  
  def index
    @template = "index"
    if params[:coach_id]
      @coach = Coach.find(params[:coach_id])
      @reports = @coach.coaching_reports
      @reports = @reports.readable_for(current_coach).order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    else
      @reports = CoachingReport.all
      @reports = @reports.common.order(created_at: :desc).paginate(page: params[:page], per_page: 30)
    end
  end

  def show
    @report = CoachingReport.readable_for(current_coach).find(params[:id])
    @comments = @report.comments
    @notifications = @comments.where(read_flag: false)
    @comments = @comments.reverse
    @template = "show"
    if params[:coaching_report_id]
      @comments = Comment.find(params[:coaching_report_id])
    end
  end

  def new
    @report = CoachingReport.new
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
    params.require(:coaching_report).permit(:title, :body, :status)
  end
  
  def full_profile
    if (current_coach.name == nil) && (current_coach.university == nil) && (current_coach.major == nil) && (current_coach.school_year == nil) && (current_coach.self_introduction == nil)
      flash[:info] = "プロフィール情報を完成させるとレポートを作成できるようになります"
      redirect_to current_coach
    end
  end
  
end

class CommentsController < ApplicationController
  before_action :logged_in_as_coach?
  before_action :correct_comment_coach?, only: [:destroy]
  
  def index
    @coach = Coach.find(params[:coach_id])
    coach_id = @coach.id
    @comments = Comment.where(coach_id: coach_id).order("created_at DESC")
    comment_ids = @comments.map{ |comment| comment.coaching_report_id }.uniq
    @reports = CoachingReport.where(id: comment_ids, status: "public_for_coaches").order_by_ids(comment_ids).page(params[:page]).per_page(5)
    @template = "my-comments-index"
  end
  
  def new
  end
  
  def create
    @report = CoachingReport.find(params[:coaching_report_id])
    @comment = Comment.new(comment_params)
    @comment.coaching_report_id = @report.id
    @comment.commented_coach_id = @report.coach_id
    @comment.coach_id = current_coach.id
    @comment.commenter = current_coach.name
    if @comment.save
      flash[:success] = "コメントしました。"
      redirect_to coaching_report_path(@report)
    else
      flash[:danger] = "コメントを正しく入力してください。"
      redirect_to coaching_report_path(@report)
    end
  end
  
  def show
  end
  
  def edit
    @comment = current_coach.comments.find(params[:id])
  end
  
  def update
    @comment = current_coach.comments.find(params[:id])
    @comment.assign_attributes(comment_params)
    if @comment.save
      flash[:success] = "コメントを更新しました。"
      redirect_to @coach
    else
      render "edit"
    end
  end
  
  def destroy
    @report = CoachingReport.find(params[:coaching_report_id])
    @comment = @report.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to coaching_report_path(@report)
  end
  
  
  private
  
  def comment_params
    params.require(:comment).permit(:commenter, :body, :coach_id, :coaching_report_id, :commented_coach_id)
  end
  
  def correct_comment_coach?
    @report = CoachingReport.find(params[:coaching_report_id])
    @comment = Comment.find(params[:id])
    unless current_coach.id == @comment.coach_id
      flash[:danger] = "Not correct commenter!"
      redirect_to coaching_report_path(@report)
    end
  end
  
end

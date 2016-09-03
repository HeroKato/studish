class NotificationsController < ApplicationController
  before_action :logged_in?
  after_action :save_read_flag, only: [:index]
  
  def index
    current_coach_id = current_coach.id
    @comments = Comment.where(commented_coach_id: current_coach_id).order("created_at DESC")
    comment_ids = @comments.map{ |comment| comment.coaching_report_id }.uniq
    @reports = CoachingReport.where(id: comment_ids).order_by_ids(comment_ids)
  end
  
end

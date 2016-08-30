class NotificationsController < ApplicationController
  before_action :logged_in?
  after_action :save_read_flag, only: [:index]
  
  def index
    current_coach_id = current_coach.id
    @comments = Comment.where(read_flag: false, commented_coach_id: current_coach_id)
    comment_ids = @comments.map{ |comment| comment.coaching_report_id }.uniq
    @reports = CoachingReport.where(id: comment_ids)
  end
  
  
  
end

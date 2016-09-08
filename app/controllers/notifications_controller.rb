class NotificationsController < ApplicationController
  before_action :logged_in?
  after_action :save_flags, only: [:index]
  
  def index
    @comments = Comment.where(commented_coach_id: current_coach.id).order("created_at DESC")
    #comment_ids = @comments.map{ |comment| comment.coaching_report_id }.uniq
    #@reports = CoachingReport.where(id: comment_ids).order_by_ids(comment_ids)
    @favorites = Favorite.where(favorited_coach_id: current_coach.id).order("created_at DESC")
    notifications = @comments.push(@favorites)
    @notifications = notifications.flatten!
    @created_at = @notifications.map{|n| n.created_at }
    @notifications = @notifications.sort_by{ |n| n.created_at }
    @notifications = @notifications.reverse
  end
  
end

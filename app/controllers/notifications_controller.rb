class NotificationsController < ApplicationController
  before_action :correct_coach, only: [:index]
  after_action :save_flags, only: [:index]
  
  def index
    #@comments = Comment.where(commented_coach_id: current_coach.id).order("created_at DESC")
    #comment_ids = @comments.map{ |comment| comment.coaching_report_id }.uniq
    #@reports = CoachingReport.where(id: comment_ids).order_by_ids(comment_ids)
    @favorited = Favorite.where(favorited_coach_id: current_coach.id).uniq
    #notifications = @comments.push(@favorites)
    #@notifications = notifications.flatten!
    #@created_at = @notifications.map{|n| n.created_at }
    #@notifications = @notifications.sort_by{ |n| n.created_at }
    #@notifications = @notifications.reverse
    @commented = PostComment.where(commented_coach_id: current_coach.id)
    @notifications = @commented.push(@favorited)
    @notifications.flatten!
    @notifications = @notifications.sort_by{ |n| n.created_at }
    @notifications = @notifications.reverse
    @notifications = Kaminari.paginate_array(@notifications).page(params[:page]).per(5)
  end
  
end

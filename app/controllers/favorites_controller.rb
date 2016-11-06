class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    if params[:post_comment_id]
      @post_comment = PostComment.find(params[:post_comment_id])
      if logged_in_as_student?
        @favorite = current_student.favorites.build(post_comment_id: :post_comment_id)
      elsif logged_in_as_coach?
        @favorite = current_coach.favorites.build(post_comment_id: :post_comment_id)
      end
      if @post_comment.student_id
        @favorite.favorited_student_id = @post_comment.student.id
      else
        @favorite.favorited_coach_id = @post_comment.coach.id
      end
      @favorite.post_comment_id = @post_comment.id
      
    else
      @post = Post.find(params[:post_id])
      if logged_in_as_student?
        @favorite = current_student.favorites.build(post: @post)
      elsif logged_in_as_coach?
        @favorite = current_coach.favorites.build(post: @post)
      end
      @favorite.favorited_student_id = @post.student.id
      @favorite.post_id = @post.id
    end
    #@report = CoachingReport.find(params[:coaching_report_id])
    #@favorite = current_coach.favorites.build(coaching_report: @report)
    #@favorite.favorited_coach_id = @report.author.id
    
    if @favorite.save
      flash[:success] = "お気に入りに登録しました"
      redirect_to :back
    else
      flash[:info] = "すでにお気に入りに登録してあります"
      redirect_to @post
    end
  end
  
  def destroy
    if params[:post_comment_id]
      @post_comment = PostComment.find(params[:post_comment_id])
      if logged_in_as_student?
        @favorite = current_student.favorites.find_by!(post_comment_id: params[:post_comment_id])
      elsif logged_in_as_coach?
        @favorite = current_coach.favorites.find_by!(post_comment_id: params[:post_comment_id])
      end
    else
      @post = Post.find(params[:post_id])
      if logged_in_as_student?
        @favorite = current_student.favorites.find_by!(post_id: params[:post_id])
      elsif logged_in_as_coach?
        @favorite = current_coach.favorites.find_by!(post_id: params[:post_id])
      end
    #@report = CoachingReport.find(params[:coaching_report_id])
    #@favorite = current_coach.favorites.find_by!(coaching_report_id: params[:coaching_report_id])
    end
    @favorite.destroy
    flash[:success] = "お気に入りから削除しました"
    redirect_to :back
  end
end

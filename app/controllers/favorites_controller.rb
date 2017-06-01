class FavoritesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]
  
  def create
    @favorite = current_user.favorites.build(favorite_params)
    #if params[:post_comment_id]
    #  @post_comment = PostComment.find(params[:post_comment_id])
    #  @favorite = current_user.favorites.build(post_comment_id: :post_comment_id)
    #  @favorite.favorited_student_id = @post_comment.student.id
    #  @favorite.post_comment_id = @post_comment.id
    #else
    #  @post = Post.find(params[:post_id])
    #  if logged_in_as_student?
    #    @favorite = current_student.favorites.build(post: @post)
    #  elsif logged_in_as_coach?
    #    @favorite = current_coach.favorites.build(post: @post)
    #  end
    #  @favorite.favorited_student_id = @post.student.id
    #  @favorite.post_id = @post.id
    #end
    #@report = CoachingReport.find(params[:coaching_report_id])
    #@favorite = current_coach.favorites.build(coaching_report: @report)
    #@favorite.favorited_coach_id = @report.author.id
    
    if @favorite.save
      flash[:success] = "いいねしました！"
      redirect_to request.referrer || root_url
    else
      flash[:info] = "すでにいいねしてあります。"
      redirect_to request.referrer || root_url
    end
  end
  
  def destroy
    #if params[:post_comment_id]
    #  @post_comment = PostComment.find(params[:post_comment_id])
    #  if logged_in_as_student?
    #    @favorite = current_student.favorites.find_by!(post_comment_id: params[:post_comment_id])
    #  elsif logged_in_as_coach?
    #    @favorite = current_coach.favorites.find_by!(post_comment_id: params[:post_comment_id])
    #  end
    #else
    #  @post = Post.find(params[:post_id])
    #  if logged_in_as_student?
    #    @favorite = current_student.favorites.find_by!(post_id: params[:post_id])
    #  elsif logged_in_as_coach?
    #    @favorite = current_coach.favorites.find_by!(post_id: params[:post_id])
    #  end
    #@report = CoachingReport.find(params[:coaching_report_id])
    #@favorite = current_coach.favorites.find_by!(coaching_report_id: params[:coaching_report_id])
    #end
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    flash[:success] = "いいねを削除しました"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def favorite_params
    params.permit(:user_id, :post_id, :favorited_user_id, :post_comment_id)
  end
  
  def correct_user
    @user = User.find_by(id: params[:user_id])
    redirect_to request.refferer || root_url unless current_user?(@user)
  end
  
end

class FavoritesController < ApplicationController
  before_action :logged_in_as_coach?
  
  def create
    @report = CoachingReport.find(params[:coaching_report_id])
    @favorite = current_coach.favorites.build(coaching_report: @report)
    @favorite.favorited_coach_id = @report.author.id
    
    if @favorite.save
      flash[:success] = "お気に入りに登録しました"
      redirect_to @report
    else
      flash[:info] = "すでにお気に入りに登録してあります"
      redirect_to @report
    end
  end
  
  def destroy
    @report = CoachingReport.find(params[:coaching_report_id])
    @favorite = current_coach.favorites.find_by!(coaching_report_id: params[:coaching_report_id])
    @favorite.destroy
    flash[:success] = "お気に入りから削除しました"
    redirect_to @report
  end
end

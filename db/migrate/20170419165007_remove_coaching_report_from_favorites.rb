class RemoveCoachingReportFromFavorites < ActiveRecord::Migration
  
  def change
    remove_column :favorites, :coaching_report_id, :integer
    remove_column :favorites, :coaching_report, :integer
    remove_column :favorites, :coaching_reports, :integer
  end
  
end
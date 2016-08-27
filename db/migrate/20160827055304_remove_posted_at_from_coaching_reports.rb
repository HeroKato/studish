class RemovePostedAtFromCoachingReports < ActiveRecord::Migration
  def change
    remove_column :coaching_reports, :posted_at, :datetime
  end
end

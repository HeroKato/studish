class Favorite < ActiveRecord::Base
  belongs_to :coach
  belongs_to :coaching_report
  
  validates :coach, presence: true
  validates :coach_id, uniqueness: { scope: :coaching_report_id }
  validates :coaching_report, presence: true
end

class Favorite < ActiveRecord::Base
  belongs_to :student, foreign_key: :student_id
  belongs_to :coach, foreign_key: :coach_id
  belongs_to :post, foreign_key: :post_id
  belongs_to :post_comment, foreign_key: :post_comment_id
  #belongs_to :coaching_report
  
  #validates :coach, presence: true
  #validates :coach_id, uniqueness: { scope: :coaching_report_id }
  #validates :coaching_report, presence: true
end

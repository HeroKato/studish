class Favorite < ActiveRecord::Base
  #belongs_to :student, foreign_key: :student_id
  #belongs_to :coach, foreign_key: :coach_id
  belongs_to :user
  belongs_to :post, foreign_key: :post_id
  belongs_to :post_comment, foreign_key: :post_comment_id
  #belongs_to :coaching_report
  before_create :favorited?
  
  #validates :coach, presence: true
  #validates :coach_id, uniqueness: { scope: :coaching_report_id }
  #validates :coaching_report, presence: true
  validates :user_id, presence: true
  validates :favorited_user_id, presence: true
  validates :post_id, presence: true, :if => :favorite_for_post?
  validates :post_comment_id, presence: true, :if => :favorite_for_post_comment?
  
  private
  
  def favorited?
    if self.post_id
      Favorite.find_by(user_id: self.user_id, post_id: self.post_id).blank?
    elsif self.post_comment_id
      Favorite.find_by(user_id: self.user_id, post_comment_id: self.post_comment_id).blank?
    end
  end
  
  def favorite_for_post?
    self.post_id.present?
  end
  
  def favorite_for_post_comment?
    self.post_comment_id.present?
  end
end

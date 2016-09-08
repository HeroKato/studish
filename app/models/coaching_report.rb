class CoachingReport < ActiveRecord::Base
  belongs_to :author, class_name: "Coach", foreign_key: "coach_id"
  
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :coach
  
  has_many :favorites, dependent: :destroy
  has_many :favoriters, through: :favorites, source: :coach
  
  STATUS_VALUES = %w(draft public_for_coaches unpublic_for_coaches)
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1200 }
  validates :status, inclusion: { in: STATUS_VALUES }
  
  scope :common, -> { where(status: "public_for_coaches") }
  scope :full, -> (coach) { where("status <> ? OR coach_id = ?", "draft", coach.id) }
  scope :readable_for, -> (coach) { where("status = ? OR coach_id = ?", "public_for_coaches", coach.id) }
  
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.coaching_report.status_#{status}")
    end
    
    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
  
  def self.order_by_ids(comment_ids)
    order_by = ["case"]
    comment_ids.each_with_index.map do |id, index|
      order_by << "WHEN id='#{id}' THEN #{index}"
    end
    order_by << "end"
    order(order_by.join(" "))
  end
  
  def favorited_by?(coach)
    favorites.where(coach_id: coach.id).exists?
  end
  
  def commented_by?(coach) 
    comments.where(coach_id: coach.id).exists?
  end
end

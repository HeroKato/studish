class CoachingReport < ActiveRecord::Base
  belongs_to :author, class_name: "Coach", foreign_key: "coach_id"
  
  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :coach
  
  STATUS_VALUES = %w(draft public_for_coaches unpublic_for_coaches)
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 1200 }
  validates :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }
  
  scope :common, -> { where(status: "public_for_coaches") }
  scope :published, -> { where("status <> ?", "draft") }
  scope :full, -> (coach) { where("status <> ? OR coach_id = ?", "draft", coach.id) }
  scope :readable_for, -> (coach) { coach ? full(coach) : common }
  
  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.coaching_report.status_#{status}")
    end
    
    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end

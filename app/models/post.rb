class Post < ActiveRecord::Base
  belongs_to :student
  has_many :post_pictures, dependent: :destroy
  accepts_nested_attributes_for :post_pictures, allow_destroy: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  
  validates :student_id, presence: true
  validates :caption, presence: true, length: { maximum: 1000 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :text_name, presence: true, unless: :study_or_note?, length: { maximum: 100 }
  validates :number, presence: true, unless: :study_or_note?, length: { maximum: 30 }
  validates :chapter, length: { maximum: 50 }
  validates :section, length: { maximum: 50 }
  validates :pattern, length: { maximum: 50 }
  
  def study_or_note?
    subject == "勉強方法"||"note"
  end
end
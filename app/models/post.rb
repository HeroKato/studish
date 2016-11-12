class Post < ActiveRecord::Base
  belongs_to :student
  has_many :post_pictures, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  accepts_nested_attributes_for :post_pictures, allow_destroy: true
  
  validates :student_id, presence: true
  validates :caption, presence: true, length: { maximum: 1000 }
  validates :subject, presence: true, length: { maximum: 20 }
  validates :text_name, presence: true, length: { maximum: 100 }
  validates :number, presence: true, length: { maximum: 30 }
  validates :chapter, length: { maximum: 50 }
  validates :section, length: { maximum: 50 }
  validates :pattern, length: { maximum: 50 }
end
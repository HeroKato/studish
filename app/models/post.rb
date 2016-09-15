class Post < ActiveRecord::Base
  belongs_to :student
  default_scope -> { order(created_at: :desc) }
  has_many :post_pictures, dependent: :destroy
  accepts_nested_attributes_for :post_pictures
  
  validates :student_id, presence: true
  
  validates :caption, length: { maximum: 1000 }
end
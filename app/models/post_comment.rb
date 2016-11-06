class PostComment < ActiveRecord::Base
  belongs_to :student
  belongs_to :coach
  belongs_to :post
  has_many :comment_pictures, dependent: :destroy
  accepts_nested_attributes_for :comment_pictures, allow_destroy: true
  has_many :favorites, dependent: :destroy
  
  validates :post_id, presence: true
  validates :caption, presence: true, length: { maximum: 1000 }
end

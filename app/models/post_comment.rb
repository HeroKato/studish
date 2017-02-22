class PostComment < ActiveRecord::Base
  belongs_to :student
  belongs_to :coach
  belongs_to :post
  has_many :comment_pictures, dependent: :destroy
  accepts_nested_attributes_for :comment_pictures, allow_destroy: true
  has_many :favorites, dependent: :destroy
  
  has_many :branch_post_comments, class_name: "PostComment", foreign_key: "root_post_comment_id"
  belongs_to :root_post_comments, class_name: "PostComment"
  
  validates :post_id, presence: true
  validates :caption, presence: true, length: { maximum: 1000 }
end
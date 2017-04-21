class CommentPicture < ActiveRecord::Base
  belongs_to :student
  belongs_to :coach
  belongs_to :post_comment
  mount_uploader :pictures, CommentPictureUploader
  validate :picture_size
  
  private
  
  def picture_size
    if pictures.size > 5.megabytes
      errors.add(:pictures, "should be less than 5MB")
    end
  end
end
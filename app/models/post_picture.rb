class PostPicture < ActiveRecord::Base
  belongs_to :student
  belongs_to :post
  mount_uploader :pictures, PostPictureUploader
  
  validate :picture_size
  
  private
  
  def picture_size
    if pictures.size > 5.megabytes
      errors.add(:pictures, "should be less than 5MB")
    end
  end
end
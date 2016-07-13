class Coach < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  
  has_one :image, class_name: "CoachImage", dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true
  
  validates :name, presence: true,
            format: { with: /\A[A-Za-z]\w*\z/, allow_blank: false, message: :invalid_coach_name },
            length: { minimum: 2, maximum: 30, allow_blank: false },
            uniqueness: { case_sensitive: true }
            
  validates :full_name, presence: true, length: { maximum: 30 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, :allow_blank => false, message: :invalid_email },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password,
    :length => { :minimum => 8, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }
  
  validates :university,        presence: true, length: { minimum: 2, maximum: 30 }
  validates :major,             presence: true, length: { minimum: 2, maximum: 50 }
  validates :school_year,       presence: true, length: { minimum: 1, maximum: 20 }
  validates :subject,           presence: true, length: { minimum: 1, maximum: 100 }
  validates :self_introduction, presence: true, length: { minimum: 1, maximum: 400 }
  validates :coach_images,      presence: true
  
  
  private
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
end

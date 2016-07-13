class Coach < ActiveRecord::Base
  attr_accessor :remember_token
  
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
  
  
  # 与えられた文字列のハッシュ値を返す
  def Coach.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)
  end
  
  # ランダムなトークンを返す
  def Coach.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続的セッションで使用するユーザー(講師)をデータベースに記憶する
  def remember
    self.remember_token = Coach.new_token
    update_attribute(:remember_digest, Coach.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtureを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  private
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
end

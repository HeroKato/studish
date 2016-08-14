class Coach < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :picture, :reset_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  after_save :remove_picture_folder if Rails.env.test? #テスト時に生成される画像フォルダをsave後に消去
  mount_uploader :picture, PictureUploader
  
  has_one :subjects, class_name: "CoachingSubject", dependent: :destroy
  accepts_nested_attributes_for :subjects, allow_destroy: true
  
  validates :picture, presence: true
  validate :picture_size
  
  validates :name, presence: true,
            format: { with: /\A[A-Za-z]\w*\z/, allow_blank: false, message: :invalid_coach_name },
            length: { minimum: 2, maximum: 30, allow_blank: false },
            uniqueness: { case_sensitive: true }
            
  validates :full_name, presence: true, length: { maximum: 30 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, :allow_blank => false, message: :invalid_email },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, allow_nil: true,
    :length => { :minimum => 8, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }
  
  validates :university,        presence: true, length: { minimum: 2, maximum: 30 }
  validates :major,             presence: true, length: { minimum: 2, maximum: 50 }
  validates :school_year,       presence: true, length: { minimum: 1, maximum: 20 }
  validates :self_introduction, presence: true, length: { minimum: 1, maximum: 400 }
  
  VALID_SKYPE_REGEX = /\A[a-z\d]+[\w+\-.,]+\z/i
  validates :skype, format: { with: VALID_SKYPE_REGEX, :allow_blank => false, message: :invalid_skype },
                    length: { minimum: 6, maximum: 32 },
                    uniqueness: { case_sensitive: false }
                    
  VALID_PHONE_REGEX = /\A[0-9]+[0-9\-]+\z/
  validates :phone, format: { with: VALID_PHONE_REGEX, :allow_blank => false, message: :invalid_phone },
                    length: { minimum: 10, maximum: 13 },
                    uniqueness: true
  
  # 与えられた文字列のハッシュ値を返す
  def Coach.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # アカウント有効化のためのメールを送信する
  def send_activation_email
    CoachMailer.account_activation(self).deliver_now
  end
  
  # テスト時に生成される画像フォルダをsave後に消去
  def remove_picture_folder
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/tmp"])
  end
  
  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = Coach.new_token
    update_attribute(:reset_digest, Coach.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # パスワード再設定のメールを送信する
  def send_password_reset_email
    CoachMailer.password_reset(self).deliver_now
  end
  
  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
  
  def validate_password?
    password.present? || password_confirmation.present?
  end
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
  
  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token = Coach.new_token
    self.activation_digest = Coach.digest(activation_token)
  end
end

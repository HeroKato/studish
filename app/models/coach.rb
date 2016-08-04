class Coach < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :picture
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  after_save :remove_picture_folder if Rails.env.test? #テスト時に生成される画像フォルダをsave後に消去
  mount_uploader :picture, PictureUploader
  
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
  validates :subject,           presence: true, length: { minimum: 1, maximum: 100 }
  validates :self_introduction, presence: true, length: { minimum: 1, maximum: 400 }
  
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

class Student < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  
  VALID_NAME_REGEX = /\A(?:[\w\-.・･]|\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/
  validates :name, allow_blank: true,
            format: { with: VALID_NAME_REGEX, message: :invalid_name },
            length: { minimum: 2, maximum: 30 },
            uniqueness: { case_sensitive: true }
  validates :name, presence: true, on: :normal_update
            
  VALID_ACCOUNT_NAME_REGEX = /\A(?:[\w\-.・･]|\p{Hiragana}|\p{Katakana}|[一-龠々])+(?:\p{blank}|[\w+\-.]|\p{Hiragana}|\p{Katakana}|[一-龠々])(?:[\w\-.]|\p{Hiragana}|\p{Katakana}|[一-龠々])+\z/
  validates :account_name, presence: true,
            format: { with: VALID_ACCOUNT_NAME_REGEX, allow_blank: false, message: :invalid_account_name },
            length: { minimum: 6, maximum: 30 },
            uniqueness: { case_sensitive: true }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX, :allow_blank => false, message: :invalid_email },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, allow_nil: true,
    :length => { :minimum => 8, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }
  
  validates :self_introduction, length: { maximum: 1000 }, allow_blank: true
    
  # 与えられた文字列のハッシュ値を返す
  def Student.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST:
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def Student.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続的セッションで使用するユーザー(生徒)をデータベースに記憶する
  def remember
    self.remember_token = Student.new_token
    update_attribute(:remember_digest, Student.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
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
    StudentMailer.account_activation(self).deliver_now
  end
  
  # テスト時に生成される画像フォルダをsave後に消去
  def remove_picture_folder
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/tmp"])
  end
  
  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = Student.new_token
    update_attribute(:reset_digest, Student.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # パスワード再設定のメールを送信する
  def send_password_reset_email
    StudentMailer.password_reset(self).deliver_now
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
    self.activation_token = Student.new_token
    self.activation_digest = Student.digest(activation_token)
  end
end

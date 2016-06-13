class Inquiry
  include ActiveModel::Model #ここでActiveModelを読み込んで、DBと繋がらないモデルとしている
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :name, :email, :category, :grade, :skype, :message #これ大事

  validates :grade, :presence => {:message => '学年を選択してください'}
  validates :name, :presence => {:message => '名前を入力してください'}, length: { maximum: 50 }
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}, format: { with: VALID_EMAIL_REGEX, :message => 'メールアドレスを正しく入力してください', :allow_blank => true }
  validates :message, length: {:message => 'お問い合わせ内容は1000文字以内でお書きください。', maximum: 1000 }
end
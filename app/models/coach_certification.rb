class CoachCertification < ActiveRecord::Base
  belongs_to :coach
  belongs_to :user, -> { where(user_type: coach)}
  
  VALID_TOEIC = /\A([5]|[1-9][05]|[1-9][0-8][05]|990)\z/
  validates :toeic, format: { with: VALID_TOEIC, message: :invalid_toeic }, allow_blank: true
  
  VALID_TOEFL = /\A([1-9]|[1-9][0-9]|1[01][0-9]|120)\z/
  validates :toefl, format: { with: VALID_TOEFL, message: :invalid_toefl }, allow_blank: true
  
  VALID_IELTS = /\A(0\.[5]|1\.[05]|2\.[05]|3\.[05]|4\.[05]|5\.[05]|6\.[05]|7\.[05]|8\.[05]|9.[0])\z/
  validates :ielts, format: { with: VALID_IELTS, message: :invalid_ielts }, allow_blank: true
  
  VALID_KANKEN = /\A(5[級]|4[級]|3[級]|[準]2[級]|2[級]|[準]1[級]|1[級])\z/
  validates :kanken, format: { with: VALID_KANKEN, message: :invalid_kanken }, allow_blank: true
  
  VALID_EIKEN = /\A(5[級]|4[級]|3[級]|[準]2[級]|2[級]|[準]1[級]|1[級])\z/
  validates :eiken, format: { with: VALID_EIKEN, message: :invalid_eiken }, allow_blank: true
  
  VALID_SUUKEN = /\A(5[級]|4[級]|3[級]|[準]2[級]|2[級]|[準]1[級]|1[級])\z/
  validates :suuken, format: { with: VALID_SUUKEN, message: :invalid_suuken }, allow_blank: true
end

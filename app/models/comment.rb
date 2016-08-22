class Comment < ActiveRecord::Base
  belongs_to :coaching_report
  belongs_to :coach
  
  validates :body, presence: true, length: { maximum: 1000 }
end

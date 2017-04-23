class CoachingSubject < ActiveRecord::Base
  belongs_to :coach
  belongs_to :user, -> { where(user_type: coach)}
end
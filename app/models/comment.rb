class Comment < ActiveRecord::Base
  belongs_to :coaching_report
  belongs_to :coach
end

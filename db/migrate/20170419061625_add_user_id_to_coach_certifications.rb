class AddUserIdToCoachCertifications < ActiveRecord::Migration
  def change
    add_reference :coach_certifications, :user, index: true, foreign_key: true
  end
end

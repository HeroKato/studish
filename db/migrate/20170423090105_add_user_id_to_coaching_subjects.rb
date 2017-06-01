class AddUserIdToCoachingSubjects < ActiveRecord::Migration
  def change
    add_reference :coaching_subjects, :user, index: true
  end
end
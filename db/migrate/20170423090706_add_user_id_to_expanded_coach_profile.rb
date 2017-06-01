class AddUserIdToExpandedCoachProfile < ActiveRecord::Migration
  def change
    add_reference :expanded_coach_profiles, :user, index: true
  end
end

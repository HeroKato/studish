class AddCommentedCoachIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commented_coach_id, :integer
  end
end

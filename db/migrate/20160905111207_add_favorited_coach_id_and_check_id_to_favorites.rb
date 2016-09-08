class AddFavoritedCoachIdAndCheckIdToFavorites < ActiveRecord::Migration
  def change
    add_column :favorites, :favorited_coach_id, :integer, default: nil
    add_column :favorites, :check_flag, :boolean, default: false
  end
end

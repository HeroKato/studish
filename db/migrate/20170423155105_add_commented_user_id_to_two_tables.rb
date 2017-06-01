class AddCommentedUserIdToTwoTables < ActiveRecord::Migration
  
  def change
    add_column :post_comments, :commented_user_id, :integer
    add_column :favorites, :favorited_user_id, :integer
  end
end

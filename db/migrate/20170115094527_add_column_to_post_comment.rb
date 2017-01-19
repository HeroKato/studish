class AddColumnToPostComment < ActiveRecord::Migration
  def change
    add_column :post_comments, :commented_post_comment_id, :integer
    add_column :post_comments, :root_post_comment_id, :integer
  end
end

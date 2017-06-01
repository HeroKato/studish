class AddUserIdToPostComments < ActiveRecord::Migration
  def change
    add_reference :post_comments, :user, index: true
  end
end
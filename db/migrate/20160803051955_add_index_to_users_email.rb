class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :coaches, :email, unique: true
  end
end

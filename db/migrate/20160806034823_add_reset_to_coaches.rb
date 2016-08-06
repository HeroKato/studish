class AddResetToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :reset_digest, :string
    add_column :coaches, :reset_sent_at, :datetime
  end
end

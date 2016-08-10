class AddIndexToCoachesEmail < ActiveRecord::Migration
  def change
    add_index :coaches, :email, unique: true
  end
end

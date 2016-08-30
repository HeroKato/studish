class AddReadFlagToComments < ActiveRecord::Migration
  def change
    add_column :comments, :read_flag, :boolean, default: false
  end
end

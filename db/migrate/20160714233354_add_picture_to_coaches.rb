class AddPictureToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :picture, :string
  end
end

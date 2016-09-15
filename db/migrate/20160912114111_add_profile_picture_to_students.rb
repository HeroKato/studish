class AddProfilePictureToStudents < ActiveRecord::Migration
  def change
    add_column :students, :profile_picture, :string
  end
end

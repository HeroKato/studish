class CreateCommentPictures < ActiveRecord::Migration
  def change
    create_table :comment_pictures do |t|
      t.references :student
      t.references :coach
      t.references :post_comment, foreign_key: true
      t.string :pictures

      t.timestamps null: false
    end
    
    add_index :comment_pictures, :post_comment_id
    add_index :comment_pictures, [:student_id, :created_at]
    add_index :comment_pictures, [:coach_id, :created_at]
    add_index :comment_pictures, [:post_comment_id, :created_at]
  end
end

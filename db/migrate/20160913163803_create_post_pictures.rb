class CreatePostPictures < ActiveRecord::Migration
  def change
    create_table :post_pictures do |t|
      t.references :student, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.string :pictures

      t.timestamps null: false
    end
    
    add_index :post_pictures, [:student_id, :created_at]
    add_index :post_pictures, [:post_id, :created_at]
  end
end

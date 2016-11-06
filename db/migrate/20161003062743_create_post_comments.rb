class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.references :student
      t.references :coach
      t.references :post, foreign_key: true
      t.integer :commented_student_id
      t.integer :commented_coach_id
      t.text :caption
      t.string :status, null: :false, default: "answer"
      t.boolean :check_flag, default: false

      t.timestamps null: false
    end
    
    add_index :post_comments, :post_id
    add_index :post_comments, [:student_id, :created_at]
    add_index :post_comments, [:coach_id, :created_at]
    add_index :post_comments, [:post_id, :created_at]
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :student
      t.references :coach
      t.integer :commented_student_id
      t.integer :commented_coach_id
      t.text :caption
      t.string :status, null: false, default: "question"

      t.timestamps null: false
    end
    
    add_index :posts, [:student_id, :created_at]
    add_index :posts, [:coach_id, :created_at]
  end
end

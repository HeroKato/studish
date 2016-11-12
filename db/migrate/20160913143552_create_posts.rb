class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :student
      t.references :coach
      t.integer :commented_student_id
      t.integer :commented_coach_id
      t.text :caption
      t.string :status, null: false, default: "question"
      
      t.string :subject, default: nil
      t.string :text_name, default: nil
      t.string :chapter, default: nil
      t.string :section, default: nil
      t.string :page, default: nil
      t.string :number, default: nil
      t.string :pattern, default: nil

      t.timestamps null: false
    end
    
    add_index :posts, [:student_id, :created_at]
    add_index :posts, [:coach_id, :created_at]
    add_index :posts, [:subject, :created_at]
    add_index :posts, [:text_name, :created_at]
    add_index :posts, [:chapter, :created_at]
    add_index :posts, [:section, :created_at]
    add_index :posts, [:pattern, :created_at]
  end
end

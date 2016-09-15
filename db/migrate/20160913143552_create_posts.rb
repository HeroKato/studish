class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :student, index: true, foreign_key: true
      t.text :caption
      t.string :status, null: false, default: "public"

      t.timestamps null: false
    end
    
    add_index :posts, [:student_id, :created_at]
  end
end

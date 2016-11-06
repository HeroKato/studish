class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :student
      t.references :coach
      t.references :favorited_student
      t.references :favorited_coach
      t.references :post
      t.references :post_comment
      t.references :coaching_report
      t.boolean    :check_flag,           default: false

      t.timestamps null: false
    end
    
    add_index :favorites, :student_id
    add_index :favorites, :coach_id
    add_index :favorites, :favorited_student_id
    add_index :favorites, :favorited_coach_id
    add_index :favorites, :post_id
    add_index :favorites, :post_comment_id
    add_index :favorites, :coaching_report_id
    add_index :favorites, :check_flag
    add_index :favorites, :created_at
  end
end

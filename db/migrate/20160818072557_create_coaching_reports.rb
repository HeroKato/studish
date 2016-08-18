class CreateCoachingReports < ActiveRecord::Migration
  def change
    create_table :coaching_reports do |t|
      t.references :coach, null: false
      t.string :title, null: false
      t.string :student_name
      t.string :subject
      t.text :body
      t.datetime :posted_at, null: false
      t.string :status, null: false, default: "draft"

      t.timestamps null: false
    end
    
    add_index :coaching_reports, :coach_id
  end
end

class CreateCoachingReports < ActiveRecord::Migration
  def change
    create_table :coaching_reports do |t|
      t.references :coach, null: false
      t.string :title, null: false
      t.text :body
      t.string :status, null: false, default: "draft"

      t.timestamps null: false
    end
    
    add_index :coaching_reports, :coach_id
  end
end

class CreateCoachCertifications < ActiveRecord::Migration
  def change
    create_table :coach_certifications do |t|
      t.references :coach, null: false          # 外部キー
      
      t.string :eiken
      t.integer :toeic, default: nil
      t.integer :toefl, default: nil
      t.float :ielts, default: nil
      t.string :kanken
      t.string :suuken

      t.timestamps null: false
    end
    
    add_index :coach_certifications, :coach_id
  end
end

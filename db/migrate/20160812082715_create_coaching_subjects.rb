class CreateCoachingSubjects < ActiveRecord::Migration
  def change
    create_table :coaching_subjects do |t|
      t.references :coach, null: false          # 外部キー
      t.string :jr_english
      t.string :jr_japanese
      t.string :jr_math
      t.string :jr_science
      t.string :jr_social
      t.string :high_english
      t.string :modern_japanese
      t.string :classical_japanese
      t.string :classical_chinese
      t.string :world_history_a
      t.string :world_history_b
      t.string :japanese_history_a
      t.string :japanese_history_b
      t.string :geography_a
      t.string :geography_b
      t.string :contemporary_society
      t.string :ethics
      t.string :politics_economics
      t.string :math_1a
      t.string :math_2b
      t.string :math_3
      t.string :basic_physics
      t.string :physics
      t.string :basic_chemistry
      t.string :chemistry
      t.string :basic_biology
      t.string :biology
      t.string :basic_earth_science
      t.string :earth_science

      t.timestamps null: false
    end
    
    add_index :coaching_subjects, :coach_id
  end
end
